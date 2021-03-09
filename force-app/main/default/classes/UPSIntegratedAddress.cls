public  class UPSIntegratedAddress {
    public class UPSIntegrationException extends Exception{}
    @AuraEnabled(cacheable=false)
    public static String validateAddress(Map<String, String> address){
        try {
            System.debug(address);
            Http h = new Http();            
            HttpRequest req = new HttpRequest();
            //req.setEndpoint('https://wwwcie.ups.com/addressvalidation/v1/1');
            req.setEndpoint('https://onlinetools.ups.com/addressvalidation/v1/1');
            req.setMethod('POST');
            req.setHeader('AccessLicenseNumber', 'ED961EE604974E56');
            req.setHeader('Username', 'RyanPaceSloan');
            req.setHeader('Password', 'upsIntegration467985');
            req.setHeader('Content-Type', 'application/json');

            List<String> street = new List<String>{address.get('street')};
            String city = address.get('city');
            String state = address.get('state');
            String postalCode = address.get('postalCode');
            String country = address.get('country');

            UPS_JSON.AddressKeyFormat akf = new UPS_JSON.AddressKeyFormat();
            akf.AddressLine = street;
            akf.PoliticalDivision2 = city;
            akf.PoliticalDivision1 = state;
            akf.PostcodePrimaryLow = postalCode;
            akf.CountryCode = country;
            
            UPS_JSON upsJSON = new UPS_JSON();
            upsJSON.XAVRequest = new UPS_JSON.XAVRequest();
            upsJSON.XAVRequest.AddressKeyFormat = akf;
            String jsonBody = JSON.serialize(upsJSON);
            System.debug(jsonBody);
            req.setBody(jsonBody);
            System.debug(req);
            
            HttpResponse res = h.send(req);
            System.debug(res.getBody());
            if(res.getStatusCode() != 200){
                System.debug(res);
                return JSON.serialize(UPS_JSON_ERROR_RESPONSE.parse(res.getBody()));
            }

            System.debug(res);            
            return JSON.serialize(UPS_JSON_RESPONSE.parse(res.getBody()));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
