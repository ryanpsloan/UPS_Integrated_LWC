public class UPS_JSON_RESPONSE {

	public class Response {
		public ResponseStatus ResponseStatus;
	}

	public class Candidate {
		public AddressKeyFormat AddressKeyFormat;
	}

	public class ResponseStatus {
		public String Code;
		public String Description;
	}

	public class AddressKeyFormat {
		public String AddressLine;
		public String PoliticalDivision2;
		public String PoliticalDivision1;
		public String PostcodePrimaryLow;
		public String PostcodeExtendedLow;
		public String Region;
		public String CountryCode;
	}

	public XAVResponse XAVResponse;

	public class XAVResponse {
		public Response Response;
		public String ValidAddressIndicator;
		public Candidate Candidate;
	}
	
	public static UPS_JSON_RESPONSE parse(String json) {
		return (UPS_JSON_RESPONSE) System.JSON.deserialize(json, UPS_JSON_RESPONSE.class);
	}
}