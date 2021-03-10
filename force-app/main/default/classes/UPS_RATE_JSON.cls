public class UPS_RATE_JSON {

	public class TransactionReference {
		public String CustomerContext {get;set;}
        
        public TransactionReference(){}

		public TransactionReference(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'CustomerContext') {
							CustomerContext = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'TransactionReference consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Address {
		public String AddressLine {get;set;} 
		public String City {get;set;} 
		public String StateProvinceCode {get;set;} 
		public String PostalCode {get;set;} 
		public String CountryCode {get;set;} 

        public Address(){}
		public Address(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'AddressLine') {
							AddressLine = parser.getText();
						} else if (text == 'City') {
							City = parser.getText();
						} else if (text == 'StateProvinceCode') {
							StateProvinceCode = parser.getText();
						} else if (text == 'PostalCode') {
							PostalCode = parser.getText();
						} else if (text == 'CountryCode') {
							CountryCode = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Address consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class UnitOfMeasurement {
		public String Code {get;set;} 

        public UnitOfMeasurement(){}
		public UnitOfMeasurement(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Code') {
							Code = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'UnitOfMeasurement consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ShipmentTotalWeight {
		public Service UnitOfMeasurement {get;set;} 
		public String Weight {get;set;} 

        public ShipmentTotalWeight(){}
		public ShipmentTotalWeight(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'UnitOfMeasurement') {
							UnitOfMeasurement = new Service(parser);
						} else if (text == 'Weight') {
							Weight = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ShipmentTotalWeight consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Request {
		public String SubVersion {get;set;} 
		public TransactionReference TransactionReference {get;set;} 

        public Request(){}
		public Request(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'SubVersion') {
							SubVersion = parser.getText();
						} else if (text == 'TransactionReference') {
							TransactionReference = new TransactionReference(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Request consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Service {
		public String Code {get;set;} 
		public String Description {get;set;} 

        public Service(){}
		public Service(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Code') {
							Code = parser.getText();
						} else if (text == 'Description') {
							Description = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Service consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Dimensions {
		public UnitOfMeasurement UnitOfMeasurement {get;set;} 
		public String Length {get;set;} 
		public String Width {get;set;} 
		public String Height {get;set;} 

        public Dimensions(){}
		public Dimensions(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'UnitOfMeasurement') {
							UnitOfMeasurement = new UnitOfMeasurement(parser);
						} else if (text == 'Length') {
							Length = parser.getText();
						} else if (text == 'Width') {
							Width = parser.getText();
						} else if (text == 'Height') {
							Height = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Dimensions consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PackageWeight {
		public UnitOfMeasurement UnitOfMeasurement {get;set;} 
		public String Weight {get;set;} 

        public PackageWeight(){}
		public PackageWeight(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'UnitOfMeasurement') {
							UnitOfMeasurement = new UnitOfMeasurement(parser);
						} else if (text == 'Weight') {
							Weight = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'PackageWeight consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Shipment {
		public ShipmentRatingOptions ShipmentRatingOptions {get;set;} 
		public Shipper Shipper {get;set;} 
		public ShipTo ShipTo {get;set;} 
		public ShipFrom ShipFrom {get;set;} 
		public Service Service {get;set;} 
		public ShipmentTotalWeight ShipmentTotalWeight {get;set;} 
		public Package_Z Package_Z {get;set;} // in json: Package

        public Shipment(){}
		public Shipment(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'ShipmentRatingOptions') {
							ShipmentRatingOptions = new ShipmentRatingOptions(parser);
						} else if (text == 'Shipper') {
							Shipper = new Shipper(parser);
						} else if (text == 'ShipTo') {
							ShipTo = new ShipTo(parser);
						} else if (text == 'ShipFrom') {
							ShipFrom = new ShipFrom(parser);
						} else if (text == 'Service') {
							Service = new Service(parser);
						} else if (text == 'ShipmentTotalWeight') {
							ShipmentTotalWeight = new ShipmentTotalWeight(parser);
						} else if (text == 'Package') {
							Package_Z = new Package_Z(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Shipment consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public RateRequest RateRequest {get;set;} 

    public UPS_RATE_JSON(){}
	public UPS_RATE_JSON(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'RateRequest') {
						RateRequest = new RateRequest(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'UPS_RATE_JSON consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Shipper {
		public String Name {get;set;} 
		public String ShipperNumber {get;set;} 
		public Address Address {get;set;} 

        public Shipper(){}
		public Shipper(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Name') {
							Name = parser.getText();
						} else if (text == 'ShipperNumber') {
							ShipperNumber = parser.getText();
						} else if (text == 'Address') {
							Address = new Address(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Shipper consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ShipTo {
		public String Name {get;set;} 
		public Address Address {get;set;} 

        public ShipTo(){}
		public ShipTo(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Name') {
							Name = parser.getText();
						} else if (text == 'Address') {
							Address = new Address(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ShipTo consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

    public class ShipFrom {
		public String Name {get;set;} 
		public Address Address {get;set;} 

        public ShipFrom(){}
		public ShipFrom(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Name') {
							Name = parser.getText();
						} else if (text == 'Address') {
							Address = new Address(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ShipFrom consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Package_Z {
		public Service PackagingType {get;set;} 
		public Dimensions Dimensions {get;set;} 
		public PackageWeight PackageWeight {get;set;} 

        public Package_Z(){}
		public Package_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'PackagingType') {
							PackagingType = new Service(parser);
						} else if (text == 'Dimensions') {
							Dimensions = new Dimensions(parser);
						} else if (text == 'PackageWeight') {
							PackageWeight = new PackageWeight(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Package_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class RateRequest {
		public Request Request {get;set;} 
		public Shipment Shipment {get;set;} 

        public RateRequest(){}
		public RateRequest(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Request') {
							Request = new Request(parser);
						} else if (text == 'Shipment') {
							Shipment = new Shipment(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'RateRequest consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ShipmentRatingOptions {
		public String UserLevelDiscountIndicator {get;set;} 

        public ShipmentRatingOptions(){}
		public ShipmentRatingOptions(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'UserLevelDiscountIndicator') {
							UserLevelDiscountIndicator = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ShipmentRatingOptions consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static UPS_RATE_JSON parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new UPS_RATE_JSON(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
}
