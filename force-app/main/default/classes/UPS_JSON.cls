public class UPS_JSON {

    public class AddressKeyFormat {
        public String ConsigneeName;
        public String BuildingName;
        public List<String> AddressLine;
        public String Region;
        public String PoliticalDivision2;
        public String PoliticalDivision1;
        public String PostcodePrimaryLow;
        public String PostcodeExtendedLow;
        public String Urbanization;
        public String CountryCode;
    }

    public class XAVRequest {
        public AddressKeyFormat AddressKeyFormat;
    }

    public XAVRequest XAVRequest;

    
    public static UPS_JSON parse(String json) {
        return (UPS_JSON) System.JSON.deserialize(json, UPS_JSON.class);
    }
}
