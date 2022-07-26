@AbapCatalog.sqlViewName: 'ZIBOOKING_MXX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.ignorePropagatedAnnotations:true 

@EndUserText.label: 'Booking view'

define view ZI_BOOKING_M_XX 
  as select from /dmo/booking as Booking
  
//  association to parent ZI_Travel_M_TXX    as _Travel       on  $projection.travel_id     = _Travel.travel_id

 
  association [1..1] to /DMO/I_Customer    as _Customer     on  $projection.customer_id   = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier     as _Carrier      on  $projection.carrier_id    = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection  as _Connection   on  $projection.carrier_id    = _Connection.AirlineID
                                                            and $projection.connection_id = _Connection.ConnectionID
{               
  key travel_id,
  key booking_id,

      booking_date,
      customer_id,
      carrier_id,
      connection_id,
      flight_date,
      @Semantics.amount.currencyCode: 'currency_code'
      flight_price,
      @Semantics.currencyCode: true
      currency_code,
      @UI.hidden: true
//      _Travel.lastchangedat,   -- Take over the ETag from parent
      
      /* Associations */
//      _Travel,
      _Customer,   
      _Carrier,
      _Connection
      
}
