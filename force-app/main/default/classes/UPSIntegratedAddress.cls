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

            String jsonReturn = null;
            JSONParser parser = JSON.createParser(res.getBody());
            while (parser.nextToken() != null) {
                System.debug(parser.getCurrentName());
                if(parser.getCurrentName() == 'Candidate'){
                    parser.nextToken();
                    System.debug(parser.getCurrentToken());
                    if(parser.getCurrentToken() == JSONToken.START_ARRAY){
                        jsonReturn = JSON.serialize(UPS_JSON_RESPONSE_ARRAY.parse(res.getBody()));
                        break;
                    }else{   
                        jsonReturn = JSON.serialize(UPS_JSON_RESPONSE.parse(res.getBody()));
                        break;
                    }
                }
            }

            System.debug(res);            
            return jsonReturn;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=false)
    public static String getRates(Map<String, String> details, Map<String,String> toAddress, Map<String,String> fromAddress){
        System.debug(details);
        String shipperName = details.get('shipperName');
        String shipToName = details.get('shipToName');
        List<String> serviceTypeDetails = details.get('serviceType').split(':');
        String serviceTypeCode = serviceTypeDetails[0];
        String serviceTypeDesc = serviceTypeDetails[1];
        String packageWeight = details.get('packageWeight');
        String totalWeight = details.get('packageWeight');
        String packageLength = details.get('packageLength');
        String packageHeight = details.get('packageHeight');

        Http h = new Http();            
        HttpRequest req = new HttpRequest();
        //TO DO HEADERS
        //req.setEndpoint('https://wwwcie.ups.com/addressvalidation/v1/1');
        req.setEndpoint('https://onlinetools.ups.com/ship/v1/rating/Rate');
        req.setMethod('POST');
        req.setHeader('transId', String.valueOf(Math.random()*13570));
        req.setHeader('transactionSrc', 'RyansDevOrg');
        req.setHeader('AccessLicenseNumber', 'ED961EE604974E56');
        req.setHeader('Username', 'RyanPaceSloan');
        req.setHeader('Password', 'upsIntegration467985');
        req.setHeader('Content-Type', 'application/json');

        UPS_RATE_JSON rateJSON = new UPS_RATE_JSON();
        rateJSON.RateRequest = new UPS_RATE_JSON.RateRequest();
        rateJSON.RateRequest.Request = new UPS_RATE_JSON.Request();
        rateJSON.RateRequest.Request.SubVersion = null;
        rateJSON.RateRequest.Request.TransactionReference = new UPS_RATE_JSON.TransactionReference();
        rateJSON.RateRequest.Request.TransactionReference.CustomerContext = 'CustomerContext'; 
        rateJSON.RateRequest.Shipment = new UPS_RATE_JSON.Shipment();
        rateJSON.RateRequest.Shipment.ShipmentRatingOptions = new UPS_RATE_JSON.ShipmentRatingOptions();
        rateJSON.RateRequest.Shipment.ShipmentRatingOptions.UserLevelDiscountIndicator = 'TRUE';
        rateJSON.RateRequest.Shipment.Shipper = new UPS_RATE_JSON.Shipper();
        rateJSON.RateRequest.Shipment.Shipper.Name = shipperName;
        rateJSON.RateRequest.Shipment.Shipper.ShipperNumber = 'EE7513';
        rateJSON.RateRequest.Shipment.Shipper.Address = new UPS_RATE_JSON.Address();
        rateJSON.RateRequest.Shipment.Shipper.Address.AddressLine = fromAddress.get('street');
        rateJSON.RateRequest.Shipment.Shipper.Address.City = fromAddress.get('city');
        rateJSON.RateRequest.Shipment.Shipper.Address.StateProvinceCode = fromAddress.get('state');
        rateJSON.RateRequest.Shipment.Shipper.Address.PostalCode = fromAddress.get('postalCode');
        rateJSON.RateRequest.Shipment.Shipper.Address.CountryCode = fromAddress.get('country');
        rateJSON.RateRequest.Shipment.ShipTo = new UPS_RATE_JSON.ShipTo();
        rateJSON.RateRequest.Shipment.ShipTo.Name = shipToName;
        rateJSON.RateRequest.Shipment.ShipTo.Address = new UPS_RATE_JSON.Address();
        rateJSON.RateRequest.Shipment.ShipTo.Address.AddressLine = toAddress.get('street');
        rateJSON.RateRequest.Shipment.ShipTo.Address.City = toAddress.get('city');
        rateJSON.RateRequest.Shipment.ShipTo.Address.StateProvinceCode = toAddress.get('state');
        rateJSON.RateRequest.Shipment.ShipTo.Address.PostalCode = toAddress.get('postalCode');
        rateJSON.RateRequest.Shipment.ShipTo.Address.CountryCode = toAddress.get('country');
        rateJSON.RateRequest.Shipment.ShipFrom = new UPS_RATE_JSON.ShipFrom();
        rateJSON.RateRequest.Shipment.ShipFrom.Name = shipperName;
        rateJSON.RateRequest.Shipment.ShipFrom.Address = new UPS_RATE_JSON.Address();
        rateJSON.RateRequest.Shipment.ShipFrom.Address.AddressLine = fromAddress.get('street');
        rateJSON.RateRequest.Shipment.ShipFrom.Address.City = fromAddress.get('city');
        rateJSON.RateRequest.Shipment.ShipFrom.Address.StateProvinceCode = fromAddress.get('state');
        rateJSON.RateRequest.Shipment.ShipFrom.Address.PostalCode = fromAddress.get('postalCode');
        rateJSON.RateRequest.Shipment.ShipFrom.Address.CountryCode = fromAddress.get('country');
        rateJSON.RateRequest.Shipment.Service = new UPS_RATE_JSON.Service();
        rateJSON.RateRequest.Shipment.Service.Code = serviceTypeCode;
        rateJSON.RateRequest.Shipment.Service.Description = serviceTypeDesc;
        rateJSON.RateRequest.Shipment.ShipmentTotalWeight = new UPS_RATE_JSON.ShipmentTotalWeight();
        rateJSON.RateRequest.Shipment.ShipmentTotalWeight.UnitOfMeasurement = new UPS_RATE_JSON.Service();
        rateJSON.RateRequest.Shipment.ShipmentTotalWeight.UnitOfMeasurement.Code = 'LBS';
        rateJSON.RateRequest.Shipment.ShipmentTotalWeight.UnitOfMeasurement.Description = 'Pounds';
        rateJSON.RateRequest.Shipment.ShipmentTotalWeight.Weight = packageWeight;
        rateJSON.RateRequest.Shipment.Package_Z = new UPS_RATE_JSON.Package_Z();
        rateJSON.RateRequest.Shipment.Package_Z.PackagingType = new UPS_RATE_JSON.Service();
        rateJSON.RateRequest.Shipment.Package_Z.PackagingType.Code = '02';
        rateJSON.RateRequest.Shipment.Package_Z.PackagingType.Description = 'Package';
        rateJSON.RateRequest.Shipment.Package_Z.Dimensions = new UPS_RATE_JSON.Dimensions();
        rateJSON.RateRequest.Shipment.Package_Z.Dimensions.UnitOfMeasurement = new UPS_RATE_JSON.UnitOfMeasurement();
        rateJSON.RateRequest.Shipment.Package_Z.Dimensions.UnitOfMeasurement.Code = 'IN';
        rateJSON.RateRequest.Shipment.Package_Z.Dimensions.Length = packageLength;
        rateJSON.RateRequest.Shipment.Package_Z.Dimensions.Width = packageWeight;
        rateJSON.RateRequest.Shipment.Package_Z.Dimensions.Height = packageHeight;
        rateJSON.RateRequest.Shipment.Package_Z.PackageWeight = new UPS_RATE_JSON.PackageWeight();
        rateJSON.RateRequest.Shipment.Package_Z.PackageWeight.UnitOfMeasurement = new UPS_RATE_JSON.UnitOfMeasurement();
        rateJSON.RateRequest.Shipment.Package_Z.PackageWeight.UnitOfMeasurement.Code = 'LBS';
        rateJSON.RateRequest.Shipment.Package_Z.PackageWeight.Weight = packageWeight;
        System.debug(rateJSON);
        String jsonBody = JSON.serialize(rateJSON);
        jsonBody = jsonBody.replace('Package_Z', 'Package');
        System.debug(jsonBody);
        req.setBody(jsonBody);
        System.debug(req);

        HttpResponse res = h.send(req);
        System.debug(res.getBody());
        if(res.getStatusCode() != 200){
            System.debug(res);
            return JSON.serialize(UPS_JSON_ERROR_RESPONSE.parse(res.getBody()));
        }

        return JSON.serialize(UPS_RATE_JSON_RESPONSE.parse(res.getBody()));
    }
}
