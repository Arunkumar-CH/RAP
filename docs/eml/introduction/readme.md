##### Previous Step
[Home](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/wiki)



# Introduction

Entity Manipulation Language (EML) is a part of the ABAP language that is used to **control the business object’s behavior** in the context of **ABAP RESTful programming model**. It provides a **type-save read** and **modifying access to data** in transactional development. scenarios.

## Consumption of Business Objects Using EML

Business objects that are implemented with the ABAP RESTful architecture based on the behavior definition and implementation of the interaction phase and save sequence in behavior pools can be consumed not only by means of OData protocol (Fiori UIs, or Web APIs) but also directly in ABAP by using the EML syntax.

There are two flavors of EML available:

•	A standard API, which uses the signature of the business object related entities

•	A generic API for dynamic/generic consumption of business objects.

The standard API is used whenever the "target" business object is statically specified. It provides code completion and static code checks. This typed API provides statements for read-only access to data `READ ENTITIES`, as well as for modifying data access `MODIFY ENTITIES` and for triggering the save sequence `COMMIT ENTITIES`.

The generic API is typically used for generic integration of business objects into other frameworks, such as the Cloud Data Migration Cockpit or the Process Test Framework.

**NOTE:** One of the uses cases of EML is the writing of test modules as ABAP Unit tests. As ABAP application developer, it gives you the ability to test transactional behavior of business objects for each relevant operation that is defined in the behavior definition.



##### Next Steps
[Consuming Business Object using EML](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/blob/master/docs/eml/consumptionofeml/readme.md)
