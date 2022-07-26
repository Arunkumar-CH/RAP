@Metadata.layer: #CORE
@EndUserText.label: 'Travel view - CDS data model'
annotate view ZI_TRAVEL_U_XX
  with 
{
  

  @UI: { lineItem:       [ { 
                            position: 10, 
                            importance: #HIGH ,
                            label: 'Travel ID'},
                            { type: #FOR_ACTION, dataAction: 'set_status_booked', label: 'Set To Booked' } 
                         ],
       
         selectionField: [ { position: 10 } ] }
 
  TravelID;

  @UI: { lineItem:       [ { position: 20,
                             importance: #HIGH,
                             label: 'Agency ID' } ],
        
         selectionField: [ { position: 20 } ] }

  AgencyID;

  @UI: { lineItem:       [ { position: 30,
                             importance: #HIGH,
                             label: 'Customer Number' } ],
        
         selectionField: [ { position: 30 } ] }
 
 
  CustomerID;

  @UI: { lineItem:       [ { position: 40,
                              importance: #MEDIUM,
                              label: 'Start Date' } ] }
  BeginDate;

  @UI: { lineItem:       [ { position: 41,
                             importance: #MEDIUM,
                             label: 'End Date' } ] }
  EndDate;

 

  @UI: { lineItem:       [ { position: 45,
                             importance: #MEDIUM } ]
         }
  Memo;
  
  @UI: { lineItem:       [ { position: 50, importance: #HIGH , label: 'Travel Status'} ]
        }
  Status;

  _Agency;
}