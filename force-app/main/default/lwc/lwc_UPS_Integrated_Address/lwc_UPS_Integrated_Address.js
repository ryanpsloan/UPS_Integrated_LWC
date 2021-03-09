import { LightningElement, wire, track, api } from 'lwc';
import validateAddress from '@salesforce/apex/UPSIntegratedAddress.validateAddress';
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

    @api error = undefined;
    @api fromError = undefined;
    @api toError = undefined;
    @api toIsValid = undefined;
    @api fromIsValid = undefined;

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
                /*if(element.name == 'street'){
                    this.fromAddress.street = element.value;
                }else if(element.name == 'city'){
                    this.fromAddress.city = element.value;
                }else if(element.name == 'state'){
                    this.fromAddress.state = element.value;
                }else if(element.name == 'postalCode'){
                    this.fromAddress.postalCode = element.value;
                }*/
            });
            console.log(this.fromAddress);
            this.handleCalloutFromAddress();
        } /* else {
            alert('Please update the invalid form entries and try again.');
        } */
        
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
                /*if(element.name == 'street'){
                    this.toAddress.street = element.value;
                }else if(element.name == 'city'){
                    this.toAddress.city = element.value;
                }else if(element.name == 'state'){
                    this.toAddress.state = element.value;
                }else if(element.name == 'postalCode'){
                    this.toAddress.postalCode = element.value;
                }*/
            });
            console.log(this.toAddress);
            this.handleCalloutToAddress();
        } /* else {
            alert('Please update the invalid form entries and try again.');
        } */
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
}

