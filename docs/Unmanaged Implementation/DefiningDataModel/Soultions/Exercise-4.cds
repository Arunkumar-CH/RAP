@AbapCatalog.sqlViewName: 'ZAGENCY_URP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Agency view - CDS data model'
define view ZI_Agency_U_RP
  as select from /dmo/agency as Agency
  association [0..1] to I_Country as _Country on $projection.CountryCode = _Country.Country
{

  key Agency.agency_id     as AgencyID,
      Agency.name          as Name,
      Agency.street        as Street,
      Agency.postal_code   as PostalCode,
      Agency.city          as City,
      Agency.country_code  as CountryCode,
      Agency.phone_number  as PhoneNumber,
      Agency.email_address as EMailAddress,
      Agency.web_address   as WebAddress,
      _Country

}
