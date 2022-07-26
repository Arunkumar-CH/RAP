[HOME](https://github.wdf.sap.corp/DevelopmentLearning/restful-abap/wiki)

# Defining the Data Model with CDS 
* [Introduction](#introduction)
* [Exercise 1 - Implementing the Travel and Booking Interface CDS View as a Data Model](#exercise-1)

<a id="#introduction"></a>
# Introduction

From a structural point of view, a business object consists of a tree of entities that are linked by compositions. Every entity in this composition tree is an element that is modeled with a CDS entity.
For our demo travel booking scenario, we will implement a 2-level hierarchy composition tree.
As depicted in the figure below, the 2-tier entity hierarchy for managing transactional data in our scenario consists of the following editable entities, with a 1: N cardinality on each level:
* Travel
* Booking

i.e. each travel instance has 0..N bookings
The figure below shows the composition relationship between the travel and the (flight) booking entities, where the travel entity represents the root of the data model.

![DataModel](images/M1Img1.png)

Travel data of our demo application is distributed across two database tables: a table for the travel header data `/dmo/travel` and a table for flight bookings `/dmo/booking`.

In this module you create CDS view entities as the basis for the data model of our demo scenario. 

To define a data model based on the ABAP CDS view concept, you first need to create a data definition as the relevant ABAP Repository object using a wizard in ABAP Development Tools.

<a id="exercise-1"></a>
# Exercise 1 - Implementing the Travel and Booking Interface CDS View as a Data Model

1. Duplicate the CDS view entity **ZI_TRAVEL_M_TPL** to your local package $TMP. To open the CDS view you can use shortcut `Cltr + Shift + A` and give the CDS view name in search string and click on **OK** button.

![DataModel](images/M1Img3.png)

2. Make sure **link with editor** is selected in project explorer so that CDS view location can be identified.

![DataModel](images/M1Img4.png)

3. Right click on CDS view **ZI_Travel_M_TPL** in the project explorer and select **Duplicate**

![DataModel](images/M1Img5.png)

4.	Wizard opens to copy the data definition give below details and click on Finish

    a.	Travel CDS View Name: `ZI_TRAVEL_M_XX` (Replace XX with your initials)
    
    b.	Package: `$TMP` (local object)

![DataModel](images/M1Img5.png)

![DataModel](images/M1Img6.png)

5.	Repeat steps 1 to 5 and duplicate the CDS view entity `ZI_BOOKING_M_TPL` to local package.
    
6.	Click on icon **Activate Inactive ABAP Development Objects (`Ctrl + Shift + F3`)** to activate both Travel and Booking CDS view entities

7.	Select Travel - `ZI_TRAVEL_M_XX`, Booking - `ZI_BOOKING_M_XX` CDS view entities and click on Activate button then both CDS views will be activated.

![DataModel](images/M1Img7.png)

#### Solution 
Solution for this exercise can be found [here](/docs/Managed%20Implementation/DataModelManaged/Solutions/readme.md)

**Next Steps**

[Developing Transactional App Based on Managed Scenario](/docs/Managed%20Implementation/DevelopingTransactionalAppM/README.md)
