public class UPS_RATE_JSON_RESPONSE {

	public class Response {
		public ResponseStatus ResponseStatus;
		public List<ResponseStatus> Alert;
		public TransactionReference TransactionReference;
	}

	public class ItemizedCharges {
		public String Code;
		public String CurrencyCode;
		public String MonetaryValue;
		public String SubType;
	}

	public class TransactionReference {
		public String CustomerContext;
		public String TransactionIdentifier;
	}

	public class ResponseStatus {
		public String Code;
		public String Description;
	}

	public class BillingWeight {
		public ResponseStatus UnitOfMeasurement;
		public String Weight;
	}

	public class RateResponse {
		public Response Response;
		public RatedShipment RatedShipment;
	}

	public class TransportationCharges {
		public String CurrencyCode;
		public String MonetaryValue;
	}

	public class RatedPackage {
		public TransportationCharges TransportationCharges;
		public TransportationCharges BaseServiceCharge;
		public TransportationCharges ServiceOptionsCharges;
		public List<ItemizedCharges> ItemizedCharges;
		public TransportationCharges TotalCharges;
		public String Weight;
		public BillingWeight BillingWeight;
	}

	public RateResponse RateResponse;

	public class RatedShipment {
		public ResponseStatus Service;
		public List<ResponseStatus> RatedShipmentAlert;
		public BillingWeight BillingWeight;
		public TransportationCharges TransportationCharges;
		public TransportationCharges BaseServiceCharge;
		public TransportationCharges ServiceOptionsCharges;
		public TransportationCharges TotalCharges;
		public RatedPackage RatedPackage;
	}

	
	public static UPS_RATE_JSON_RESPONSE parse(String json) {
		return (UPS_RATE_JSON_RESPONSE) System.JSON.deserialize(json, UPS_RATE_JSON_RESPONSE.class);
	}
}
