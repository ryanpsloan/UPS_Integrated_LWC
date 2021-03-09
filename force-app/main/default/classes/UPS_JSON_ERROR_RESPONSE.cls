public class UPS_JSON_ERROR_RESPONSE {

    public class Response {
        public List<Errors> errors;
    }

    public class Errors {
        public String code;
        public String message;
    }

    public Response response;

    
    public static UPS_JSON_ERROR_RESPONSE parse(String json) {
        return (UPS_JSON_ERROR_RESPONSE) System.JSON.deserialize(json, UPS_JSON_ERROR_RESPONSE.class);
    }
}
