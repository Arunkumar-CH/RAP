@AbapCatalog.sqlViewName: 'ZAGENCY_UXX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Agency View - CDS Data Model'
define view ZI_Agency_U_XX
  as select from /dmo/agency as Agency
  association [0..1] to I_Country as _Country on $projection.CountryCode = _Country.Country
{

  key   Agency.agency_id     as AgencyID,
        @Semantics.text: true
        Agency.name          as Name,
        Agency.street        as Street,
        Agency.postal_code   as PostalCode,
        @Search.defaultSearchElement: true
        @Search.fuzzinessThreshold: 0.7

        Agency.city          as City,
        @Search.defaultSearchElement: true
        @Search.fuzzinessThreshold: 0.7

        Agency.country_code  as CountryCode,
        Agency.phone_number  as PhoneNumber,
        Agency.email_address as EmailAddress,
        Agency.web_address   as WebAddress,
        _Country

}
