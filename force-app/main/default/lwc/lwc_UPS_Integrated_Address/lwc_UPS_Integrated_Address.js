import { LightningElement, wire, track, api } from 'lwc';
import validateAddress from '@salesforce/apex/UPSIntegratedAddress.validateAddress';
import getRates from '@salesforce/apex/UPSIntegratedAddress.getRates';
export default class lwc_UPS_Integrated_Address extends LightningElement {
    @track selectedStep = 'Step1';
 
    handleNext() {
        var getselectedStep = this.selectedStep;
        if(getselectedStep === 'Step1'){
            //this.selectedStep = 'Step2';
            this.selectStep2();
        }
        else if(getselectedStep === 'Step2'){
            //this.selectedStep = 'Step3';
            this.selectStep3();
        }
        else if(getselectedStep === 'Step3'){
            //this.selectedStep = 'Step4';
            this.selectStep4();
        }
    }
 
    handlePrev() {
        var getselectedStep = this.selectedStep;
        if(getselectedStep === 'Step2'){
            //this.selectedStep = 'Step1';
            this.selectStep1();
        }
        else if(getselectedStep === 'Step3'){
            //this.selectedStep = 'Step2';
            this.selectStep2();
        }
        else if(getselectedStep === 'Step4'){
            //this.selectedStep = 'Step3';
            this.selectStep3();
        }
    }
      
    handleFinish() {
        alert('Finished...');
        this.selectedStep = 'Step1';
        this.fromAddress = {
            street: '',
            city: '',
            state: '',
            postalCode: '',
            country: 'US',
        };;
        this.toAddress = {
            street: '',
            city: '',
            state: '',
            postalCode: '',
            country: 'US',
        };
        this.fromIsValid = false;
        this.toIsValid = false;
        this.details = {
            shipperName: '',
            shipToName: '',
            serviceType: '',
            packageWeight: '',
            packageLength: '',
            packageWidth: '',
            packageHeight: ''
        };
        this.detailsAreValid = false;
        this.rateData = {
            BillingWeight: {
                Weight: ''
            },
            Alerts: [],
            Charges:{
                Total: '',
                CurrencyCode: 'USD'
            }
    
        }
    }
      
    selectStep1() {
        this.selectedStep = 'Step1';
    }
 
    selectStep2() {
        this.selectedStep = 'Step2';
    }
 
    selectStep3() {
        this.selectedStep = 'Step3';
    }
 
    selectStep4() {
        this.selectedStep = 'Step4';
    }

    @api
    get isSelectStep1(){
        return this.selectedStep === "Step1";
    }

    @api
    get isSelectStep2(){
        return this.selectedStep === "Step2";
    }

    @api
    get isSelectStep3(){
        return this.selectedStep === "Step3";
    }

    @api
    get isSelectStep4() {
        return this.selectedStep === "Step4";
    }

    @api
    get isStep4andIsValidated() {
        return this.selectedStep === "Step4" && this.detailsAreValid;
    }

    @api error = undefined;
    @api fromError = undefined;
    @api toError = undefined;
    @api toIsValid = false;
    @api fromIsValid = false;

    @track fromAddress = {
        street: '',
        city: '',
        state: '',
        postalCode: '',
        country: 'US',
    };

    @track toAddress = {
        street: '',
        city: '',
        state: '',
        postalCode: '',
        country: 'US',
    };

    handleClickFrom(event) {
        console.log(event.target.label);
        const allValid = [...this.template.querySelectorAll('.fromAddress')]
            .reduce((validSoFar, inputCmp) => {
                        inputCmp.reportValidity();
                        return validSoFar && inputCmp.checkValidity();
            }, true);
        if (allValid) {
            var input = this.template.querySelectorAll('.fromAddress');
            console.log(input);
            this.fromAddress.country = 'US';
            input.forEach(element => {
                console.log(element.name);
                console.log(element.value);
                this.fromAddress[element.name] = element.value;

            });
            console.log(this.fromAddress);
            this.handleCalloutFromAddress();
        } 
    }

    handleClickTo(event){
        console.log(event.target.label);        
        const allValid = [...this.template.querySelectorAll('.toAddress')]
            .reduce((validSoFar, inputCmp) => {
                        inputCmp.reportValidity();
                        return validSoFar && inputCmp.checkValidity();
            }, true);
        if (allValid) {
            var input = this.template.querySelectorAll('.toAddress');
            console.log(input);
            this.toAddress.country = 'US';
            input.forEach(element => {
                console.log(element.name);
                console.log(element.value);
                this.toAddress[element.name] = element.value;
            });
            console.log(this.toAddress);
            this.handleCalloutToAddress();
        } 
    }
    
    handleCalloutFromAddress(){
        console.log(this.fromAddress);
        validateAddress({address : this.fromAddress})
        .then(result => {
            console.log(result);
            const data = JSON.parse(result);
            this.fromError = undefined;
            if(data.XAVResponse != undefined){
                if(data.XAVResponse.Response.ResponseStatus.Description == "Success"){
                    if(data.XAVResponse.Candidate != undefined && !Array.isArray(data.XAVResponse.Candidate)){
                        this.template.querySelector('.fromStreet').value = this.fromAddress.street = data.XAVResponse.Candidate.AddressKeyFormat.AddressLine;
                        this.template.querySelector('.fromCity').value = this.fromAddress.city = data.XAVResponse.Candidate.AddressKeyFormat.PoliticalDivision2;
                        this.template.querySelector('.fromState').value = this.fromAddress.state = data.XAVResponse.Candidate.AddressKeyFormat.PoliticalDivision1;
                        this.template.querySelector('.fromZip').value = this.fromAddress.postalCode = data.XAVResponse.Candidate.AddressKeyFormat.PostcodePrimaryLow;
                        this.fromIsValid = true;
                    }else if(data.XAVResponse.Candidate != undefined && Array.isArray(data.XAVResponse.Candidate)){
                        this.fromIsValid = false;
                    }
                }    
                else{
                    this.fromIsValid = false;
                }
            }else{
                this.fromIsValid = false;   
            }    
        }).catch(error => {
            console.log(error);
            console.log(typeof error);
            this.fromIsValid = false;
            if(typeof error == 'object'){
                this.fromError = error.body.message;
            }else{
                this.fromError = error;
            }
        });
    }

    handleCalloutToAddress(){
        console.log(this.toAddress);
        validateAddress({address : this.toAddress})
        .then(result => {
            console.log(result);
            const data = JSON.parse(result);
            this.toError = undefined;
            if(data.XAVResponse != undefined){
                if(data.XAVResponse.Response.ResponseStatus.Description == "Success"){
                    if(data.XAVResponse.Candidate != undefined && !Array.isArray(data.XAVResponse.Candidate)){
                        this.template.querySelector('.toStreet').value = this.toAddress.street = data.XAVResponse.Candidate.AddressKeyFormat.AddressLine;
                        this.template.querySelector('.toCity').value = this.toAddress.city = data.XAVResponse.Candidate.AddressKeyFormat.PoliticalDivision2;
                        this.template.querySelector('.toState').value = this.toAddress.state = data.XAVResponse.Candidate.AddressKeyFormat.PoliticalDivision1;
                        this.template.querySelector('.toZip').value = this.toAddress.postalCode = data.XAVResponse.Candidate.AddressKeyFormat.PostcodePrimaryLow;
                        this.toIsValid = true;
                    }else if(data.XAVResponse.Candidate != undefined && Array.isArray(data.XAVResponse.Candidate)){
                        this.toIsValid = false;
                    }
                }    
                else{
                    this.toIsValid = false;
                }
            }else{
                this.toIsValid = false;   
            } 
        }).catch(error => {
            console.log(error);
            console.log(typeof error);
            this.toIsValid = false;
            if(typeof error == 'object'){
                this.toError = error.body.message;
            }else{
                this.toError = error;
            }
        });
    }

    get bothAddressesAreValid(){
        return this.fromIsValid && this.toIsValid;
    }
    
    @api detailsAreValid = false;

    get options() {
        return [
            { value: "02:UPS 2nd Day Air", label: "UPS 2nd Day Air"},
            { value: "59:UPS 2nd Day Air A.M.", label: "UPS 2nd Day Air A.M."},
            { value: "12:UPS 3 Day Select", label: "UPS 3 Day Select"},
            { value: "03:UPS Ground", label: "UPS Ground"},
            { value: "01:UPS Next Day Air", label: "UPS Next Day Air"},
            { value: "14:UPS Next Day Air Early", label: "UPS Next Day Air Early"},    
            { value: "13:UPS Next Day Air Saver", label: "UPS Next Day Air Saver"},
            { value: "75:UPS Heavy Goods", label: "UPS Heavy Goods"} 
        ];
    }

    handleServiceTypeChange(event) {
        this.value = event.detail.value;
    }

    @track details = {
        shipperName: '',
        shipToName: '',
        serviceType: '',
        packageWeight: '',
        packageLength: '',
        packageWidth: '',
        packageHeight: ''
    };

    handleClickDetails(event){
        console.log(event.target.label);
        const allValid = [...this.template.querySelectorAll('.details')]
            .reduce((validSoFar, inputCmp) => {
                        inputCmp.reportValidity();
                        return validSoFar && inputCmp.checkValidity();
            }, true);
        if (allValid) {
            var input = this.template.querySelectorAll('.details');
            console.log(input);
            this.fromAddress.country = 'US';
            input.forEach(element => {
                console.log(element.name);
                console.log(element.value);
                this.details[element.name] = element.value;
            });
            console.log(this.details);
            this.callGetRates();
        }
    }

    @api detailsError = undefined;
    @track rateData = {
        BillingWeight: {
            Weight: ''
        },
        Alerts: [],
        Charges:{
            Total: '',
            CurrencyCode: 'USD'
        }

    }

    callGetRates(){
        console.log(this.details);
        getRates({details : this.details, toAddress : this.toAddress, fromAddress: this.fromAddress})
        .then(result => {
            console.log(result);
            const data = JSON.parse(result);
            console.log(data);
            if(data.response != undefined && Array.isArray(data.response.errors)){
                this.detailsError = response.errors[0].message;
                this.detailsAreValid = false;
            }else if(data.RateResponse != undefined){
                if(data.RateResponse.Response.ResponseStatus.Description == 'Success'){
                    this.detailsError = undefined;
                    this.detailsAreValid = true;
                    this.rateData.BillingWeight.Weight = data.RateResponse.RatedShipment.BillingWeight.Weight;
                    this.rateData.Alerts = data.RateResponse.RatedShipment.RatedShipmentAlert;
                    this.rateData.Charges.Total = data.RateResponse.RatedShipment.TotalCharges.MonetaryValue;
                }else{
                    this.detailsAreValid = false;
                }
            }

        })
        .catch(error => {
            this.detailsAreValid = false;
            if(typeof error == 'object'){
                this.detailsError = error.body.message;
            }else{
                this.detailsError = error;
            }
        });
    }
}

