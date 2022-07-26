##### Previous Step
[Home](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/wiki)


# Consumption of Business object using EML

* [Introduction](#Intro)
* [Exercise 1 - Implementing **UPDATE** for Travel Data](#Exercise1)
* [Exercise 2 - Executing an **ACTION** ](#Exercise2)
* [Exercise 3 - Implementing **DELETE** for Travel Instances](#Exercise3)
* [Exercise 4 - Creating Instances Along the Composition Hierarchy - **CREATE**](#Exercise4)

<a id="Intro"></a>
# Introduction

Entity Manipulation Language (EML) is a part of the ABAP language that is used to **control the business object’s behavior** in the context of **ABAP RESTful programming model**. It provides a **type-save read** and **modifying access to data** in transactional development. scenarios.

#### Consumption of Business Objects Using EML

Business objects that are implemented with the ABAP RESTful architecture based on the behavior definition and implementation of the interaction phase and save sequence in behavior pools can be consumed not only by means of OData protocol (Fiori UIs, or Web APIs) but also directly in ABAP by using the EML syntax.

There are two flavors of EML available:

•	A standard API, which uses the signature of the business object related entities

•	A generic API for dynamic/generic consumption of business objects.

The standard API is used whenever the "target" business object is statically specified. It provides code completion and static code checks. This typed API provides statements for read-only access to data `READ ENTITIES`, as well as for modifying data access `MODIFY ENTITIES` and for triggering the save sequence `COMMIT ENTITIES`.

The generic API is typically used for generic integration of business objects into other frameworks, such as the Cloud Data Migration Cockpit or the Process Test Framework.

**NOTE:** One of the uses cases of EML is the writing of test modules as ABAP Unit tests. As ABAP application developer, it gives you the ability to test transactional behavior of business objects for each relevant operation that is defined in the behavior definition.

Business objects can be consumed not only by means of the OData protocol (for example, in Fiori UIs) but also directly in ABAP by using Entity Manipulation Language (EML).

This topic offers some code samples to demonstrate how you can access our Travel business object with EML syntax in a simple consumer class. You will get to know the core structure of EML at this point.


<a id="Exercise1"></a>
# Exercise 1 - Implementing UPDATE for Travel Data

In this exercise, two fields **agencyid** and the **memo** text should be changed to a given travel instance.

#### Prerequisites

The entity instances can only be updated in a `MODIFY` call if the update operation is specified for each relevant entity in the behavior definition and is implemented in the behavior pool accordingly. Update in the behavior implemenation is already done in Module 1.4, Exercise 6

Since the change will only affect one entity, we use the short form of the `MODIFY` syntax:

**Syntax for UPDATE**
```
MODIFY ENTITY EntityName 
    UPDATE FIELDS ( field1 field2 ..) WITH it_instance_u 
    [FAILED   ls_failed   | DATA(ls_failed)] 
    [REPORTED ls_reported | DATA(ls_reported)].
```

The **UPDATE** call allows to trigger delta updates on consumer side where only the key field and the new values need to be supplied. From provider side, it allows to identify which fields are overwritten and which need to be kept according to the DB data.

The following steps provides you with the source code of an executable consumer class. To enable the classrun mode, the consumer class implements the interface `if_oo_adt_classrun`.

Since the result data is not exported as part of the UPDATE statement, a subsequent `READ ENTITY` call is required to read the changed data from transactional buffer. The result data of the read operation is specified in the target variable `lt_received_travel_data`.

**Step 1:**  Implementing UPDATE for Travel Data. Create class zcl_eml_travel_update_xx (replace XX with your intials)

```
CLASS zcl_eml_travel_update_xx DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
```

**Step 2:** Now before changing the data, lets first check the data and then use specific travel uuid to see the change. Open CDS view **zi_travel_u_xx** and press F8 to see the data and then pick one travel uuid for which you wish to change the data or you can also open already create application through Service Binding and then pick one travel uuid.

```
CLASS zcl_eml_travel_update_xx IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(lv_travel_uuid)   = '524F32D51CC84A64A630CD10F118EE2D'. " Valid travel UUID
    DATA(lv_description)   = 'Changed Travel Agency'.
    DATA(lv_new_agency_id) = '070017'.   " Valid agency ID
...

  ENDMETHOD.
ENDCLASS.
```

**Step 3:** Now use `MODIFY ENTITY` syntax to modify `agencyid` and `memo` of selected travel UUID.

```
...
    " UPDATE travel data
    MODIFY ENTITY zi_travel_u_xx
    UPDATE FIELDS ( agencyid memo ) WITH
            VALUE #( (
              traveluuid        = lv_travel_uuid
              agencyid          = lv_new_agency_id
              memo              = lv_description ) )
    FAILED   DATA(ls_failed)
    REPORTED DATA(ls_reported).
...
```

**Step 4:** Now lets read the transactional buffer to see if the change is made or not. 


```
...
    " Read travel data from transactional buffer
 CLEAR: ls_reported, ls_failed.
      READ ENTITY zi_travel_u_xx
            FIELDS ( agencyid memo )
            WITH VALUE #( ( traveluuid = lv_travel_uuid ) )
            RESULT DATA(lt_received_travel_data)
      REPORTED ls_reported
      FAILED   ls_failed.

    " Output result data on the console
    out->write( lt_received_travel_data ).
…
```
Run the code by executing **F9**

**Step 5:** After this you will not get output becuase `READ METHOD` was not implemented in Behavior Implementation. Now we need to implement READ method in our Behavior implementation. Go to implementation class of unmanaged application `ZCL_BP_TRAVEL_U_XX`. Implement the READ method with below code

```
  METHOD read.
  
  SELECT * FROM /dmo/a_travel_d INTO TABLE @DATA(lt_travel) FOR ALL ENTRIES IN @keys WHERE travel_uuid EQ @keys-traveluuid.

    data(lt_create_buffer) = zcl_travel_buffer=>get_instance(  )->get_mt_travel_create( ).
    data(lt_update_buffer) = zcl_travel_buffer=>get_instance(  )->get_mt_travel_update( ).
    data(lt_delete_buffer) = zcl_travel_buffer=>get_instance(  )->get_mt_travel_delete( ).

    LOOP AT keys INTO data(key).
      READ TABLE lt_create_buffer ASSIGNING FIELD-SYMBOL(<s_create_buffer>) WITH KEY travel_uuid = key-traveluuid.
      IF sy-subrc = 0.
        INSERT <s_create_buffer> INTO TABLE lt_travel.
      ENDIF.

      READ TABLE lt_update_buffer ASSIGNING FIELD-SYMBOL(<s_update_buffer>) WITH KEY travel_uuid = key-traveluuid.
      IF sy-subrc = 0.
        MODIFY TABLE lt_travel FROM <s_update_buffer>.
      ENDIF.

      READ TABLE lt_delete_buffer TRANSPORTING NO FIELDS WITH KEY travel_uuid = key-traveluuid.
      IF sy-subrc = 0.
        DELETE lt_travel WHERE travel_uuid = key-traveluuid.
      ENDIF.

    ENDLOOP.

    result = CORRESPONDING #( lt_travel MAPPING TO ENTITY ).
    
    ENDMETHOD.
```

**Step 6:** Now in the class `zcl_eml_travel_update_xx(replace XX with your intials)` insert `COMMIT ENTITIES` to save the transactional buffer to database

```
...
    " Persist changed travel data in the database
    COMMIT ENTITIES.
...
```
#### Solution 
Solution for this exercise can be found [here](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/blob/master/docs/eml/consumptionofeml/Solutions/zcl_eml_travel_update_xx.abapclass)


<a id="Exercise2"></a>
# Exercise2 - Executing an ACTION

All modify operations in EML that cannot be implemented by standard operations (create, update, delete) are handled by actions.
This exercise will demonstrate the implementation of an action related to a given travel instance. 

#### Prerequisites

The `SET_STATUS_BOOKED` action is specified in the behavior definition at the root entity level and is implemented in the behavior pool accordingly.
This action is implemented in Module 1.4, Exercise 8.

The `MODIFY` statement uses the following general syntax for executing an action:

##### Syntax for UPDATE

```
MODIFY ENTITY EntityName  
    EXECUTE action_name FROM it_instance_a 
      [RESULT result_action | DATA(result_action)] 
    [FAILED   ls_failed     | DATA(ls_failed)] 
    [REPORTED ls_reported   | DATA(ls_reported)].
 
 ```

The `action_name` refers to the name of an action as it is defined in the behavior definition for the corresponding entity, which is referred by the name of the CDS entity EntityName. The input parameter `it_instance_a` is a table type containing the keys field information.

The syntax for executing an action allows exporting of result data. The result data of an action execution is specified in the target variable `result_action`.

The following steps provides you with the source code of an executable consumer class implementing the execution of `set_status_booked` action for a selected travel instance. Again, to enable the class-run mode, the consumer class implements the `if_oo_adt_classrun` interface.

Step 1: First create class `zcl_eml_travel_action_xx` (Replace XX with your initials) and then add interface – `IF_OO_ADT_CLASSRUN` to execute class directly.

Step 2: First figure out that Travel UUID as we did in previous exercise for which you want to change the Booking status, using unmanaged application created before.

Step3: Execute the action statement
```
...
   DATA(lv_travel_uuid)     = '42010AEEC82A1EEBB3BFA80707C5EF70'. " Valid travel UUID (status != B)
    " EXECUTE action for travel data
    MODIFY ENTITY ZI_Travel_U_XX
           EXECUTE set_status_booked
                FROM VALUE #( ( traveluuid = lv_travel_uuid ) )
                RESULT DATA(lt_set_status_booked)
           FAILED   DATA(ls_failed)
           REPORTED DATA(ls_reported).
...
```
Step 3: Now lets see the output of this action. For this write `OUT->WRITE( lt_set_status_booked[ 1 ]-%param-status )` after Modify statement. It should print B
```
…
    OUT->WRITE( lt_set_status_booked[ 1 ]-%param-status ).
…
```

Step 4: Finally write `COMMIT ENTITES` to update the status in Database.
```
…
COMMIT ENTITIES.
…
```

Checking Results
To check the results of the MODIFY call, run the main method of the class from listing above by pressing F9 key and then view the received `RESULT data (lt_set_status_booked)` on the console output.

#### Solution 
Solution for this exercise can be found [here](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/blob/master/docs/eml/consumptionofeml/Solutions/zcl_eml_travel_action_xx.abapclass)


<a id="Exercise3"></a>
# Exercise 3 - Implementing DELETE for Travel Instances

This example demonstrates how you can implement multiple `DELETE` operations for different entities in one `MODIFY` call. In this case, we use MODIFY statement that allows you to collect multiple operations on multiple entities of one business object that is identified by RootEntityName.

#### Prerequisites

The entity instances can only be deleted in a MODIFY call if the delete operation is specified for each relevant entity in the behavior definition and is implemented in the behavior pool(s) accordingly. This is done in Module 1.4, Exercise 7. 

#### Syntax for DELETE 

```
MODIFY ENTITIES OF RootEntityName 
  ENTITY entity_1_name       
    DELETE FROM it_instance1_d 
 
     ...
  [FAILED   DATA(it_failed)] 
  [REPORTED DATA(it_reported)].

```
To delete individual instances of entities, the keys of the entity must be specified in the **FROM** clause of the **MODIFY** statement.

Each **DELETE** operation has a table of instances as input parameters: `it_instance1_d` and `it_instance1_d`, which provide the MODIFY call with key information.

Implementing **DELETE** for **Travel** Instance

Step 1: Create Class `zcl_eml_travel_delete_xx` (Replace XX with your initials) and add interface `if_oo_adt_classrun` (as shown below)
```
CLASS zcl_eml_travel_delete_xx DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_eml_travel_delete_xx IMPLEMENTATION.
...
```

Step 2: Now implement method `if_oo_adt_classrun~main`. First get the travel UUID you wish to delete and then set the local variables.

```
CLASS zcl_eml_travel_delete_xx IMPLEMENTATION.

…
 METHOD if_oo_adt_classrun~main.

    DATA(lv_travel_uuid_to_delete)    = '42010AEEC82A1EEBB3BFA80707C5EF70'.  " Valid UUID
…
```

Step 3: Now use `MODIFY ENTITIES` for `DELETE` as shown below
```
…
 MODIFY ENTITIES OF zi_travel_u_xx
      " Delete travel and all child instances (booking, booking supplements)
      ENTITY travel
           DELETE FROM VALUE #( ( traveluuid  = lv_travel_uuid_to_delete ) )
      REPORTED DATA(ls_reported)
      FAILED   DATA(ls_failed).
…
```
Step 4: Try to read the deleted entry and print (it should not print anything)
```
READ ENTITIES OF zi_travel_u_xx
          ENTITY travel ALL FIELDS WITH
            VALUE #( ( TravelUUID = lv_travel_uuid_to_delete ) )
            RESULT DATA(lt_received_travel_data)
      REPORTED ls_reported
      FAILED   ls_failed.

    out->write( lt_received_travel_data ).
```    

Step 5: At last `COMMIT ENTITIES` to delete data from database
```
…
    " Persist changed travel data in the database
   COMMIT ENTITIES.
  ENDMETHOD.
ENDCLASS.
…
```
#### Checking Results

To check the results of the `MODIFY` call, run the main method of the class from listing above by pressing `F9` key in the class editor and then search for data of selected instances in the data preview tool (F8 on the CDS root view DMO/I_TRAVEL_U.)

#### Solution 
Solution for this exercise can be found [here](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/blob/master/docs/eml/consumptionofeml/Solutions/zcl_eml_travel_delete_xx.abapclass)


<a id="Exercise4"></a>
# Exercise 4 - Implementing Create for Travel Instance - CREATE

This exercise demonstrates how you can implement a direct **CREATE**. In this case, **MODIFY** statement is used to collect multiple operations on multiple entities of one business object that is identified by the RootEntityName.

##### Prerequisites

The instances of entities (root or child) can only be directly created in a **MODIFY** call if the create operation is specified for the relevant entities in the behavior definition and is implemented in the behavior pool accordingly. This is done in Module 1.4, Exercise 5.

The same applies to instances of child entities that are created by association. In this case however, an association to the child entity must be specified in behavior definition and implemented in a handler method of the behavior pool. - This association usage you will be doing in Managed Implementation.

```
Syntax for CREATE (BY association)
MODIFY ENTITIES OF RootEntityName  " name of root CDS view 
  ENTITY entity_1_name             " alias name
    CREATE FROM it_instance1_c 
    CREATE BY \association1_name  FROM it_instance1_cba 
      ...
  ENTITY entity_2_name             " alias name
    CREATE BY \association2_name  FROM it_instance2_cba
     ...
  [FAILED   DATA(it_failed)] 
  [MAPPED   DATA(it_mapped)] 
  [REPORTED DATA(it_reported)].

```

NOTE: When multiple entity instances are created by one MODIFY statement, then it is required to provide the **content ID** `%CID` information for all instances (to be created) in the FROM parameter.

In addition to the content ID and the new values for the instance to be created, also a `%control` structure must be populated with information which fields were supplied. The input parameter `it_instance_c` in the `CREATE FROM` statement is a table type containing the content ID, data for further entity fields and the `%control` structure. This structure contains for each field of an entity a flag which indicates whether the field was provided with values by the consumer or not.

If the instances of child entities should to be created by an association, besides the parent key, also the new values for the child entity to be created, must be populated in the create operation. The input parameter `it_instance_cba` in the `CREATE BY \association1_name FROM` statement is therfore a table type containing the parent key (reference to content ID in case the parent instance is created in the same MODIFY call) and the `%target sub-table` that refers to the child instance to be created.

The following steps provides you with the source code of an executable consumer class that implements the creation of a new travel instance including a new booking and the associated booking supplement.

Step 1: Create class `ZCL_EML_TRAVEL_CREATE_XX` (Replace XX with your initials). 

Step 2: Use Interface `IF_OO_ADT_CASSRUN`, to directly use method to execute this class.
```
…
CLASS zcl_eml_travel_create_xx DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_eml_travel_create_xx IMPLEMENTATION.
ENDCLASS.
…
```

Step 3: Now implement `CREATE` of `MODIFY ENTITY` for user specific data
```
…
CLASS zcl_eml_travel_create_xx IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

   DATA gv_customer_id  TYPE /dmo/customer_id.

    DATA(lv_description)  = 'Intro to EML'.
    DATA(lv_agency_id)    = '070048'.
    DATA(lv_my_agency_id) = '0700999'.

    " Get valid customer ID
    SELECT SINGLE customer_id FROM /dmo/customer INTO @gv_customer_id.

    " Create a new travel > booking > booking supplement
    MODIFY ENTITIES OF zi_travel_u_xx
      ENTITY Travel
             CREATE FIELDS ( agencyid customerid begindate enddate memo status )
                    WITH VALUE #( ( %cid       = 'CID_100'    " Preliminary ID for new travel instance
                                    agencyid   = lv_agency_id
                                    customerid = gv_customer_id
                                    begindate  = '20190308'
                                    enddate    = '20190327'
                                    memo = lv_description
                                    status     = CONV #( /dmo/if_flight_legacy=>travel_status-new ) ) )
            " Update data of travel instance
             UPDATE FIELDS ( agencyid memo status )
                    WITH VALUE #( ( %cid_ref   = 'CID_100'    " Refers to travel instance
                                    agencyid   = lv_my_agency_id
                                    memo       = 'Changed Agency and Status!'
                                    status     = CONV #( /dmo/if_flight_legacy=>travel_status-planned ) ) )
       MAPPED   DATA(ls_mapped)
       FAILED   DATA(ls_failed)
       REPORTED DATA(ls_reported).

       READ ENTITIES OF zi_travel_u_xx
          ENTITY travel
          FIELDS ( agencyid memo )
            WITH VALUE #( ( TravelUUID = ls_mapped-travel[ 1 ]-TravelUUID ) )
            RESULT DATA(lt_received_travel_data)
      REPORTED ls_reported
      FAILED   ls_failed.

    out->write( lt_received_travel_data ).

    COMMIT ENTITIES.
    " Check criteria of success
    IF sy-subrc = 0.
      out->write( 'Successful COMMIT!' ).
    ELSE.
      out->write( 'COMMIT failed!' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
…
```

#### Checking Results
To check the results, run the main method of the consumer class `zcl_eml_travel_create_xx` from listing above by pressing `F9` key in the class editor and then search for the newly created travel, booking and booking supplement instances in the data preview tool (`F8` on the travel root CDS view ZI_TRAVEL_U_XX.)

#### Solution 
Solution for this exercise can be found [here](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/blob/master/docs/eml/consumptionofeml/Solutions/zcl_eml_travel_create_xx.abapclass)

#### End of Module. Return to [Home](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/wiki)

