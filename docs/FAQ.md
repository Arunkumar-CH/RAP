## Frequently Asked Questions

<!--ToC-->

[1. Why the name says Restful in RAP?](#s1) 

[2. How to port SEGW based Services into RAP world? These SEGW based Services used RDS and DPC_EXT?](#s2)

[3. What is Behavior Definition Language (in short: BDL)?](#s3)

[4. What is Business Object Projection?](#s4)

[5. What is CDS Projection View?](#s5)

[6. What is Early Numbering?](#s6)

[7. What is EML](#s7)

[8. What is ETag (Entity Tag)?](#s8)

[9. What is Feature Control?](#s9)

[10. What is Interaction Phase?](#s10)

[11. What is Late Numbering?](#s11)

[12. What is Transactional Buffer?](#s12)

[13. What is Save Sequence?](#s13)

[14. What is Web API?](#s14)

[15. What is Unmanaged Save?](#s15)

[16. What are Implicit Returning Parameters?](#s16)

[17. What does FAILED parameter do?](#s17)

[18. What does REPORTED parameter do?](#s18)

[19. What does MAPPED parameter do?](#s19)

[20. What does %CID Component do?](#s20)

[21. What does %CID_REF Component do?](#s21)

[22. What does %PID Component do?](#s22)

[23. What does %CONTROL Component do?](#s23)

[24. What does %DATA Component do?](#s24)

[25. What does %FAIL Component do?](#s25)

[26. What does %KEY Component do?](#s26)

[27. What does %MSG Component do?](#s27)

[28. What does %ELEMENT Component do?](#s28)

[29. What does %PARAM Component do?](#s29)

[30. What is Additional Save?](#s30)

[31.Regarding behavior implementation, Why do we write code in local Types, not in Global class??](#s31)

[32.What is Virtual Element?](#s32)

<a id="s1"></a>
### 1. Why the name says Restful in RAP?
Cloud solutions needs decoupling of the apps from the application server. Modern applications have to support features like device-switch, continuous work and collaboration. This sort of user experience can only be achieved if the application server resources are decoupled from the device. An ABAP session cannot live between 2 UI roundtrips. All these requirements have ensured that we use REST for interactions between UI and Server. The services designed are RESTful in nature and hence the name.

<a id="s2"></a>
### 2. How to port SEGW based Services into RAP world? These SEGW based Services used RDS and DPC_EXT?
There are currently no plans for a migration. SEGW can still be used. Even if the BO is migrated to AI, then the expectation is that SEGW RDS does not need to be changed by app side.

<a id="s3"></a>
### 3. What is Behavior Definition Language (in short: BDL)?
Declarative language for behavior modeling of business objects in the context of ABAP RESTful programming model. The language is syntactically oriented to CDS. Technically however, BDL artifacts are not managed by the ABAP Dictionary, but by the ABAP compiler.

<a id="s4"></a>
### 4. What is Business Object Projection?
A subset of a business object data model and/or business object behavior. The business object that is designed for general purpose can be restricted for a certain in a BO projection. One of the most prominent examples is the Business Partner, which can be projected as Customer, Supplier, or Vendor.

<a id="s5"></a>
### 5. What is CDS Projection View?
A CDS projection is defined in a data definition in which you can define the service-specific projected data model, a subset of the data model of the general business object.

<a id="s6"></a>
### 6. What is Early Numbering?
A numbering concept by which newly created entity instances are given a definitive key value during the interaction phase on the create operation.

<a id="s7"></a>
### 7. What is EML?
Entity Manipulation Language (in short: EML) is a part of the ABAP language that is used to implement the business object’s behavior in the context of ABAP RESTful programming model. It provides a type-save read and modifying access to data in transactional development scenarios.

<a id="s8"></a>
### 8. What is ETag (Entity Tag)?
An ETag is a field that is used to determine changes to the requested resource. Usually, fields like last changed timestamp, hash values, or version counters are used as ETags.

An ETag can be used for optimistic concurrency control in the OData protocol to help prevent simultaneous updates of a resource from overwriting each other. An ETag check is used to determine whether two representations of a business entity, are the same. Whenever the representation of the entity changes, a new and different ETag value is assigned.

<a id="s9"></a>
### 9. What is Feature Control?
A functionality that provides property settings for fields, entities, actions, or associations of a given business object

These settings control the behavior of a business object when it is in a certain state.

On the user interface, these settings control, for example, the following:

Make fields mandatory, read only, editable, and/or invisible
Enable/disable buttons
The feature control is either static (valid for all instances of an entity) or dynamic (depends on the state of the node instances).

<a id="s10"></a>
### 10. What is Interaction Phase?
A part of the BO runtime where a consumer calls the business object's operations to modify or read business data in a transactional context.

A user triggers the interaction phase by clicking the EDIT button on UI. The interaction phase ends when the user clicks the SAVE button on UI.

<a id="s11"></a>
### 11. What is Late Numbering?
Late numbering is a concept by which new entity instances are given a definitive key just before they are saved on the database.

<a id="s12"></a>
### 12. What is Transactional Buffer?
A part of the BO runtime used to store the state of the BO data that is used in the interaction phase for modifying and read operations (in a transactional context) and which can be persisted during the save sequence.

<a id="s13"></a>
### 13. What is Save Sequence?
Part of the BO runtime when data is persisted after all changes were performed. The save sequence is triggered by using the SAVE button on UIs.

<a id="s14"></a>
### 14. What is Web API?
An OData service that is published without any UI specific metadata. It is not exposed for a UI context. Instead it provides an API to access the service by another client, including from a different system or server.

<a id="s15"></a>
### 15. What is Unmanaged Save?
A processing step within the transactional life cycle of a managed business object that prevents the business object’s managed runtime from saving business data (changes) during the save sequence. In this case, the function modules (for update task) are called to save data changes of the relevant business object.

Unmanaged save is defined in the behavior definition of a managed business object and implemented in the related behavior pool.

<a id="s16"></a>
### 16. What are Implicit Returning Parameters?
When implementing a BO contract, you make use of implicit returning parameters. These parameters do not have fixed data types and instead are assigned by the compiler with the types derived from behavior definition.
The implicit parameters can be declared explicitly as CHANGING parameters in the method signature of the handler classes by using the generic type DATA. 
FAILED, REPORTED and MAPPED are implicit returning parameters.

<a id="s17"></a>
### 17. What does FAILED parameter do?
This exporting parameter is defined as a nested table which contains one table for each entity defined in the behavior definition.

The failed tables include information for identifying the data set where an error occurred:
	
• %CID and
• ID of the relevant BO instance.
	
  
The reason for the failure is specified by the predefined component:
	
• %FAIL, which stores the symptom of the failure.
  
  
<a id="s18"></a>
### 18. What does REPORTED parameter do?
This exporting parameter is used to return messages. It is defined as a nested table which contains one table for each entity defined in the behavior definition.

The reported tables include data for instance-specific messages.

The data set for which the message is relevant is identified by the following components:
• %CID
• ID of the relevant instance
• %MSG with an instance of the message interface IF_ABAP_BEHV_MESSAGE
• %ELEMENT which refers to all elements of an entity.
 
  
  <a id="s19"></a>
### 19. What does MAPPED parameter do?
This mapped parameter is defined as a nested table which contains one table for each entity defined in the behavior definition.

The mapped parameters provide the consumer with ID mapping information. They include the information about which key values were created by the application for given content IDs. The BO runtime passes the created key values in any subsequent calls in the same request and in the response.

The relevant data set is identified by the following components:
	• %CID
	• %KEY
	
  <a id="s20"></a>
### 20. What does %CID Component do?
The content ID %CID is a temporary primary key for an instance, as long as no primary key was created by the BO runtime.

The content ID is always provided by the SADL framework. It is only needed in case of internal numbering and/or late numbering. The content ID provides the reference between the related entity instances. A good example is a DEEP INSERT for multiple parent/child instances with internal numbering and/or late numbering. In this case, the references between the child and parent instances are established using the content ID %CID.


  <a id="s21"></a>
### 21. What does %CID_REF Component do?
A reference to the content ID %CID.

  <a id="s22"></a>
### 22. What does %PID Component do?
Defines the preliminary ID.

It is only used if the application does not provide a temporary primary key. It is designed for use in draft data use cases (which are not yet supported in the context of the ABAP RESTful programming model).

The preliminary ID is only available when LATE NUMBERING is defined in the behavior definition without the addition IN PLACE.

  <a id="s23"></a>
### 23. What does %CONTROL Component do?
Reflects which elements are requested by the consumer.

The fields of the %CONTROL structure provide information, depending on the operation, about which elements of the entity are supplied in the request (for CREATE and UPDATE operations) or which elements are requested in the read request (for READ operations).

For each entity element, this control structure contains a flag which indicates whether the corresponding field was provided/requested by the consumer or not.

The element names of the entity have the uniform type ABP_BEHV_FLAG.

The possible constants are defined in the basis handler class if_abap_behv=>mk-<...>. For example, the elements that have the value if_abap_behv=>mk-on in the %CONTROL structure are used to handle delta updates within the UPDATE operation.


  <a id="s24"></a>
### 24. What does %DATA Component do?
Contains all data elements of an entity (CDS view).


  <a id="s25"></a>
### 25. What does %FAIL Component do?
Stores the symptom for a failed data set (BO instance).

The possible values (unspecific, unauthorized, not_found, and so on) are defined by the ENUM type IF_ABAP_BEHV=> T_FAIL_CAUSE

  <a id="s26"></a>
### 26. What does %KEY Component do?
Contains all key elements of an entity (CDS view).

%key is part of almost all derived types, including trigger parameters in the for modify( ) method.

  <a id="s27"></a>
### 27. What does %MSG Component do?
Provides an instance of the message interface IF_ABAP_BEHV_MESSAGE.

The component %MSG of type REF TO IF_ABAP_BEHV_MESSAGE includes IF_T100_DYN_MSG. If you do not need your own implementation of this interface, then you can benefit from the provided standard implementation by using the inherited methods new_message( ) or new_message_with_text( ).

  <a id="s28"></a>
### 28. What does %ELEMENT Component do?
Refers to all elements of an entity.

 <a id="s29"></a>
### 29. What does %PARAM Component do?
Holds the import/result type of actions.

 <a id="s30"></a>
### 30. What is Additional Save?
A processing step within the transactional life cycle of a managed business object. It allows an external functionality to be invoked during the save sequence (after the managed runtime has written the changed data of the business object’s instances to the database, but before the final commit work is executed).

Additional save is defined in the behavior definition of a managed business object and implemented in the related behavior pool.

 <a id="s31"></a>
### 31. Regarding behavior implementation, Why do we write code in local Types, not in Global class??
Local Types allows us to create multiple class definitions/implementations. This is useful since we want separation of concerns in terms of Interaction Phase, Save Phase etc.

 <a id="s32"></a>
### 32. What is Virtual Element?
Element that is not persisted on the database but calculated during runtime.

A virtual element is declared with the statement VIRTUAL in CDS projection views.





















