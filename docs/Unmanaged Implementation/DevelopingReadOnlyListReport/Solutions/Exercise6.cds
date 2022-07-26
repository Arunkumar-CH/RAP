@Metadata.layer: #CORE
@EndUserText.label: 'Travel view - CDS data model'
@UI: { headerInfo: { typeName: 'Travel',
                     typeNamePlural: 'Travels'
                     },
       presentationVariant: [{ sortOrder: [{ by: 'TravelID', direction: #DESC }] }] }

@Search.searchable: true
annotate view ZI_TRAVEL_U_XX
  with 
{
  @UI.facet: [ { id:            'Travel',
                 purpose:       #STANDARD,
                 type:          #IDENTIFICATION_REFERENCE,
                 label:         'Travel',
                 position:      10 }
             ]

  @UI: { lineItem:       [ { 
                            position: 10, 
                            importance: #HIGH ,
                            label: 'Travel ID'}
                         ],
         identification: [ { position: 10 },
                           
                         ],
         selectionField: [ { position: 10 } ] }
  @EndUserText.quickInfo: 'Travel Identification for Customer.'
  @Search.defaultSearchElement: true
  TravelID;

  @UI: { lineItem:       [ { position: 20,
                             importance: #HIGH,
                             label: 'Agency ID' } ],
         identification: [ { position: 20 } ],
         selectionField: [ { position: 20 } ] }
  @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Agency', element: 'AgencyID' } }]
   @EndUserText.label: 'Agency ID'
  @Search.defaultSearchElement: true
  AgencyID;

  @UI: { lineItem:       [ { position: 30,
                             importance: #HIGH,
                             label: 'Customer Number' } ],
         identification: [ { position: 30 } ],
         selectionField: [ { position: 30 } ] }
  @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer', element: 'CustomerID'  } }]
  @EndUserText.label: 'Customer Number'
  @Search.defaultSearchElement: true
  CustomerID;

  @UI: { lineItem:       [ { position: 40,
                              importance: #MEDIUM,
                              label: 'Start Date' } ],
         identification: [ { position: 40 } ] }
  BeginDate;

  @UI: { lineItem:       [ { position: 41,
                             importance: #MEDIUM,
                             label: 'End Date' } ],
         identification: [ { position: 41 } ] }
  EndDate;

  @UI: { identification: [ { position: 42 } ] }
  BookingFee;

  @UI: { identification: [ { position: 43 } ] }
  TotalPrice;

  @Consumption.valueHelpDefinition: [{entity: { name: 'I_Currency', element: 'Currency' } }]
  CurrencyCode;

  @UI: { lineItem:       [ { position: 45,
                             importance: #MEDIUM } ],
         identification: [ { position: 45,
                            label: 'Comment' } ] }
  Memo;
  
  @UI: { lineItem:       [ { position: 50, importance: #HIGH , label: 'Travel Status'} ] ,
         identification: [ { position: 50, label: 'Status' } ] 
        }
  Status;
  @Search.defaultSearchElement: true
  _Agency;
}
