@AbapCatalog.sqlViewName: 'ZITRAVEL_MXX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel view - CDS data model'

define root view ZI_TRAVEL_M_XX
  as select from /dmo/travel          as Travel -- the travel table is the data source for this view

//  composition [0..*] of ZI_Booking_M_XX as _Booking

  association [0..1] to /DMO/I_Agency    as _Agency   on $projection.agency_id    = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer  as _Customer on $projection.customer_id  = _Customer.CustomerID
  association [0..1] to I_Currency       as _Currency on $projection.currency_code = _Currency.Currency

{   
  key travel_id,      
    agency_id,         
    customer_id,  
    begin_date,  
    end_date,   
    @Semantics.amount.currencyCode: 'currency_code'
    booking_fee,
    @Semantics.amount.currencyCode: 'currency_code'
    total_price,  
    @Semantics.currencyCode: true
    currency_code,  
    status,
    description,   
    @Semantics.user.createdBy: true 
    createdby,
    @Semantics.systemDateTime.createdAt: true       
    createdat,
    @Semantics.user.lastChangedBy: true    
    lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedat,                -- used as etag field
    
    /* Associations */
//    _Booking,
    _Agency,
    _Customer,
    _Currency
}
