
**Previous Step**

[Developing Authorization Control](/docs/Managed%20Implementation/DevelopingAuthorizationControlM/README.md)

# Enabling the Draft Handling for semantic key based scenario 

* [Exercise 1 - Enable the draft handling in the base business object](#exercise-1)
* [Exercise 2 - Enable the draft handling in the projected business object](#exercise-2)
* [Exercise 3 - Enable Early Numbering for Travel and Booking](#exercise-3)



<a id="exercise-1"></a>
# Exercise 1 - Enable the draft handling in the base business object

You will now enable the draft handling for the managed based business object (BO) with a few additions in the behavior definition.

1.	Open the base behavior definition **ZI_TRAVEL_M_XX-** where **XX** is your chosen suffix – of your business object.
You can also use the shortcut `Ctrl+Shift+A` to open ABAP development object.
 
 ![OData](Images/Draft1.png)

2.	Add the addition **with draft;** after the **managed;** keyword in the header section to enable draft handling for your business object.

```with draft;```

 ![OData](Images/Draft2.png)

3.	Specify the draft table for the travel entity, where the draft travel data will be persisted as show on the screenshot.

**Note: Draft tables are fully managed by the RAP framework at runtime**

For this, insert the code snippet provided below as shown on the screenshot. 

Do not forget to replace the placeholder **XX** with your chosen suffix.


`draft table zdtravel_xx`

 ![OData](Images/draft3.png)

4.	Do the same for the booking entity – i.e. define the draft table where the draft booking data will be persisted.

For this, insert the code snippet provided below in the booking behavior definition as shown on the screenshot.

Do not forget to replace the placeholder **xx** with your chosen suffix.


`draft table zdbook_xx`

 ![OData](Images/Draft4.png)

5.	Now, you will create the draft table **zdtravel_xx** where **XX** is your chosen suffix, to store the draft data for the travel entity.

The ADT `Quick Fix` feature can be used to generate the draft table.

For this, set the cursor on the table name, and press **Ctrl+1** to star the `Quick Fix` dialog.

 ![OData](Images/Draft5.png)

6.	Leave the defaulted values as they are in the appearing dialog and choose **Next**. 

![OData](Images/draft6.png)
 
7.	Choose **Finish** to generate the table.
The draft table is generated based on the defined model and shown in the appropriate editor.
 
 ![OData](Images/draft7.png)
 
**Note: Whenever you change the BO data model, you can again use the ADT 'Quick Fix (Ctrl+1)' to generate again the draft table definition. This will update the table definition.**

8.	Save, activate and close the table.

9.	Now also create the draft table for the booking entity **zdbook_xx** using the ADT `Quick Fix` **(Ctrl+1)**'.
 
 ![OData](Images/draft8.png)
 
 ![OData](Images/Draft9.png)
 
 ![OData](Images/draft10.png)

10.	Save, activate and close the table.
Some warnings are shown in the `Problem view.` You will now work on removing them.
 
 ![OData](Images/draft11.png)

11.	Replace the association definition in the base behavior definition to solve the warnings indicating that the associations are implicitly draft enabled as this is a draft enabled business object.
For this, use the code snippet provided below to replace the one currently defined in the `travel` behavior definition as shown on the screenshot.

`association _Booking { create; with draft; }`

 ![OData](Images/draft12.png)
 
12.	Do the same for the **_Travel** association of the booking entity.
For this, use the code snippet provided below to replace the one currently defined in the booking behavior definition as shown on the screenshot.

 `association _Travel { with draft; }`

  ![OData](Images/draft13.png)

13.	Specify a `total etag field` in the `root` entity of your BO. This is required to identify changes to `active` instances in cases where the durable lock has expired. The field **LastChangedAt** will be used for the purpose in the present scenario.

For this, use the code snippet provided below to replace the one currently defined in the `travel` behavior definition as shown on the screenshot.

`total etag LastChangedAt`

 ![OData](Images/draft14.png)
 
14.	When a draft instance is going to be activated, the SAP Fiori elements UI calls the `draft determine action` **prepare** in the backend. This call takes place in a separate `OData changeset` to allow for saving the state messages even in case the activation fails due to failing validations.
In order to execute the validations during prepare, you need to assign them to the **draft determine action prepare** trigger.

For this, insert the code snippet provided below into the travel behavior definition as shown on the screenshot.

```
  draft determine action Prepare  
 {
 
    validation validateCustomer;
    
    validation validateDates;
    
    validation validateStatus;
    
  }
  
 ```

  ![OData](Images/draft15.png)

15.	Save and activate the changes.

#### Solution 
Solution for this exercise can be found [here](/docs/Managed%20Implementation/DraftSemanticKey/Solutions/Exercise1)


<a id="exercise-2"></a>
# Exercise 2. Enable the draft handling in the projected business object
You will now enable the draft handling for the managed based business object (BO) with a few additions in the behavior definition.
1.	In the `Project Explorer`, go to your package and open the base behavior definition **ZC_TRAVEL_PROCESSOR_M_XX** - where **XX** is your chosen suffix – of your business object.

You can also use the shortcut **Ctrl+Shift+A** to open ABAP development object.

 ![OData](Images/draft2.1.png)

2.	Enable the draft handling in the projection, by adding the statement **use draft;** in the header section.

Otherwise the projection would behave like if no draft has been enabled for the business object.

`use draft;`

 ![OData](Images/draft2.2.png)

3.	Enable the draft handling for the associations exposed in the projection. For this, use the code snippets provided below to replace the respective statements in the behavior definition projection as shown on the screenshot.

Code snippet for the `travel` entity:

`use association _Booking { create; with draft; }`

Code snippet for the `booking` entity:

`use association _Travel { with draft; }`

 ![OData](Images/draft2.3.png)

4.	Save and activate the behavior definition projection.
You are now done with the behavior implementations and can run and check the enhanced SAP Fiori elements `Travel App`.

5.	Launch the Travel app in your service binding **ZTRAVEL_PROC_SB_M_XX**– where **XX** is your chosen suffix – or refresh (`F5`) it in the browser. Provide your ABAP user credentials if requested.

Press **Go** on the UI to load the back-end data.
First thing you will notice is a new filter field that allows for filtering on the Editing Status is now displayed in the filter area.
 
![OData](Images/draft2.4.png)

#### Solution 
Solution for this exercise can be found [here](/docs/Managed%20Implementation/DraftSemanticKey/Solutions/Exercise2)

<a id="exercise-3"></a>
# Exercise 3. Enable Early Numbering for Travel and Booking. 

1.	Open the base behavior definition **ZI_TRAVEL_M_XX**- where **XX** is your chosen suffix – of your business object.
You can also use the shortcut `Ctrl+Shift+A` to open ABAP development object.
 
![OData](Images/draft3.1.png)

2.	Add the addition **early numbering** keyword as shown below to enable early numbering for your travel entity. 

![OData](Images/draft3.2.png)

 
3.	The ADT `Quick Fix` feature can be used to add the earlynumbering method for travel entity.

For this, set the cursor on the table name, and press **Ctrl+1** to star the `Quick Fix` dialog.

![OData](Images/draft3.3.png)
 
4.	In the method implementation paste the below code. where XX is your chosen suffix – of your business object.

```
METHOD earlynumbering_create.

    " Mapping for already assigned travel IDs (e.g. during draft activation)
     mapped-travel = VALUE #( FOR entity IN entities WHERE ( travel_id IS NOT INITIAL )
                                                          ( %cid      = entity-%cid
                                                            %is_draft = entity-%is_draft
                                                            %key      = entity-%key ) ).

    " This should be a number range. But for the demo purpose, avoiding the need to configure this in each and every system, we select the max value ...
    
    SELECT MAX( travel_id ) FROM /dmo/travel INTO @DATA(max_travel_id).
    SELECT MAX( travel_id ) FROM zdtravel_xx INTO @DATA(max_d_travel_id).

    IF max_d_travel_id > max_travel_id.  max_travel_id = max_d_travel_id.  ENDIF.

    " Mapping for newly assigned travel IDs
    mapped-travel = VALUE #( BASE mapped-travel FOR entity IN entities INDEX INTO i
                                                    USING KEY entity
                                                    WHERE ( travel_id IS INITIAL )
                                                          ( %cid      = entity-%cid
                                                            %is_draft = entity-%is_draft
                                                            travel_id  = max_travel_id + i ) ).

  ENDMETHOD.
  
 ```

5.	Add the addition **early numbering** keyword as shown below to enable early numbering for your booking entity. 

 ![OData](Images/draft3.4.png)

6.	The ADT `Quick Fix` feature can be used to add the earlynumbering method for booking entity.

For this, set the cursor on the table name, and press **Ctrl+1** to star the `Quick Fix` dialog.

![OData](Images/draft3.5.png)

7.	In the method implementation paste the below code. where XX is your chosen suffix – of your business object.

```
 METHOD earlynumbering_cba_Booking.

    DATA: max_booking_id TYPE /dmo/booking_id.

    READ ENTITIES OF zi_travel_m_XX IN LOCAL MODE
      ENTITY Travel BY \_Booking
        FIELDS ( booking_id )
          WITH CORRESPONDING #( entities )
          RESULT DATA(bookings)
          FAILED failed.

    LOOP AT entities INTO DATA(entity).
      CLEAR: max_booking_id.
      LOOP AT bookings INTO DATA(booking) USING KEY draft WHERE %is_draft = entity-%is_draft
                                                          AND   travel_id  = entity-Travel_id.
        IF booking-Booking_id > max_booking_id.  max_booking_id = booking-Booking_id.  ENDIF.
      ENDLOOP.
      " Map bookings that already have a BookingID.
      LOOP AT entity-%target INTO DATA(already_mapped_target) WHERE Booking_id IS NOT INITIAL.
        APPEND CORRESPONDING #( already_mapped_target ) TO mapped-booking.
        IF already_mapped_target-Booking_id > max_booking_id.  max_booking_id = already_mapped_target-Booking_id.  ENDIF.
      ENDLOOP.
      " Map bookings with new BookingIDs.
      LOOP AT entity-%target INTO DATA(target) WHERE Booking_id IS INITIAL.
        max_booking_id += 5.
        APPEND CORRESPONDING #( target ) TO mapped-booking ASSIGNING FIELD-SYMBOL(<mapped_booking>).
        <mapped_booking>-Booking_id = max_booking_id.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.
  
  ```
  
8.	Feel free to play around with your app.
For example, create a new Travel.

![OData](Images/draft3.6.png)

TraveID gets field automatically because of earlynumbering.

![OData](Images/draft3.7.png)
 
While editing the fields on the object page, you immediately see the draft saving indicator at the bottom.

![OData](Images/draft3.8.png)
 
Checking the related draft table (`zdtravel_xx`) in the backend shows you the entered values so far.
 
![OData](Images/draft3.9.png)

Provide an incorrect value for the Customer ID. Choose **Create or Save**.


![OData](Images/draft3.10.png)
 
You will get a corresponding message from the backend.

![OData](Images/draft3.11.png)
 
As this is a state message, it is stored on the database and belongs to the state of the business object instance.
You can leave the screen, filter for your new `travel` record and you will see the messages directly when opening the object page, without re-validating the instance on the backend.

![OData](Images/draft3.12.png)

![OData](Images/draft3.13.png)

Correct the value and choose **Save**.
 
![OData](Images/draft3.14.png)
 
Without the need to save, you can edit the travel header along with the `booking` entries.

![OData](Images/draft3.15.png)

![OData](Images/draft3.16.png)
 
In the similar way on click on create of booking entity Booking Number gets filled automatically because of early numbering.

![OData](Images/draft3.17.png)



#### Solution 
Solution for this exercise can be found [here](/docs/Managed%20Implementation/DraftSemanticKey/Solutions/Exercise3)

#### Next Step

[Integrating Augment and Precheck in managed Business Objects](/docs/Managed%20Implementation/Augment%20and%20Precheck/README.md)

