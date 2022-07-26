@Metadata.layer: #CORE
@EndUserText.label: 'Travel view - CDS data model'
@UI: { headerInfo: { typeName: 'Travel',
                     typeNamePlural: 'Travels - UnManaged'
                      },
       presentationVariant: [{ sortOrder: [{ by: 'TravelID', direction: #DESC }] }] }
       
annotate view ZI_TRAVEL_U_XX
  with 
{
  @UI: { lineItem:       [ { 
                            position: 10, 
                            importance: #HIGH ,
                            label: 'Travel ID'}
                         ]}
                         
  @UI: { identification: [ { position: 10 }
                         ] }
                         
  @UI.facet: [ { id:            'Travel',
                 purpose:       #STANDARD,
                 type:          #IDENTIFICATION_REFERENCE,
                 label:         'Travel',
                 position:      10 }
             ]                
  @UI.selectionField: [ { position: 10 } ]
  TravelID;
  @UI: { lineItem:       [ { position: 20,
                             importance: #HIGH,
                             label: 'Agency ID' } ] }
 
  @UI: { identification: [ { position: 20 } ]}
 
  @UI.selectionField: [ { position: 20 } ]
  AgencyID;
 
  @UI: { lineItem:       [ { position: 30,
                             importance: #HIGH,
                             label: 'Customer Number' } ] }
  @UI: { identification: [ { position: 30 } ] }
  @UI.selectionField: [ { position: 30 } ]
  CustomerID;
  @UI: { lineItem:       [ { position: 40,
                              importance: #MEDIUM,
                              label: 'Start Date' } ] }
  
  @UI: {identification: [ { position: 40 } ] }
                               
  BeginDate;
  @UI: { lineItem:       [ { position: 41,
                             importance: #MEDIUM,
                             label: 'End Date' } ] }
  @UI: { identification: [ { position: 41 } ] }                             
  EndDate;

  @UI: { identification: [ { position: 42 } ] }
  BookingFee;
  @UI: { identification: [ { position: 43 } ] }
  TotalPrice;
  @UI: { identification: [ { position: 45,
                            label: 'Comment' } ] }
  Memo;
  
  @UI: { lineItem:       [ { position: 50, importance: #HIGH , label: 'Travel Status'} ]  }
  
  @UI: { identification: [ { position: 50, label: 'Status' } ] }
  
  Status;
}
