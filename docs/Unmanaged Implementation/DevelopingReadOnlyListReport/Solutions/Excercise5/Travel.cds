@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel view - CDS data model'
@Metadata.allowExtensions: true
define root view entity ZI_TRAVEL_U_XX
  as select from /dmo/a_travel_d as Travel -- the travel table is the data source for this view
  
  association [0..1] to ZI_Agency_U_XX   as _Agency   on $projection.AgencyID = _Agency.AgencyID
  association [0..1] to ZI_Customer_U_XX as _Customer on $projection.CustomerID = _Customer.CustomerID
  association [0..1] to I_Currency       as _Currency on $projection.CurrencyCode = _Currency.Currency
  

{
    key Travel.travel_uuid                                                                     as TravelUUID,
      Travel.travel_id                                                                     as TravelID,

      Travel.travel_id                                                                     as TravelIDForEdit,
      @ObjectModel.text.association:'_Agency'
      Travel.agency_id                                                                     as AgencyID,
      @ObjectModel.text.association:'_Customer'
      Travel.customer_id                                                                   as CustomerID,

      Travel.begin_date                                                                    as BeginDate,

      Travel.end_date                                                                      as EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.booking_fee                                                                   as BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.total_price                                                                   as TotalPrice,

    
      Travel.currency_code                                                                 as CurrencyCode,

      Travel.description                                                                   as Memo,

      Travel.overall_status                                                                as Status,

      @Semantics.user.createdBy: true
      Travel.local_created_by                                                              as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      Travel.local_created_at                                                              as CreatedAt,
      @Semantics.user.lastChangedBy: true
      Travel.local_last_changed_by                                                         as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      Travel.local_last_changed_at                                                         as LastChangedAt,

      /* Associations */
      _Agency,
      _Customer,
      _Currency
}
