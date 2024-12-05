/*
Blockchain Transactions API

No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)

API version: 1.0.0
*/

// Code generated by OpenAPI Generator (https://openapi-generator.tech); DO NOT EDIT.

package openapi

import (
	"encoding/json"
	"bytes"
	"fmt"
)

// checks if the FundPostRequest type satisfies the MappedNullable interface at compile time
var _ MappedNullable = &FundPostRequest{}

// FundPostRequest struct for FundPostRequest
type FundPostRequest struct {
	// User wallet address
	From string `json:"from"`
	// Project wallet address
	To string `json:"to"`
}

type _FundPostRequest FundPostRequest

// NewFundPostRequest instantiates a new FundPostRequest object
// This constructor will assign default values to properties that have it defined,
// and makes sure properties required by API are set, but the set of arguments
// will change when the set of required properties is changed
func NewFundPostRequest(from string, to string) *FundPostRequest {
	this := FundPostRequest{}
	this.From = from
	this.To = to
	return &this
}

// NewFundPostRequestWithDefaults instantiates a new FundPostRequest object
// This constructor will only assign default values to properties that have it defined,
// but it doesn't guarantee that properties required by API are set
func NewFundPostRequestWithDefaults() *FundPostRequest {
	this := FundPostRequest{}
	return &this
}

// GetFrom returns the From field value
func (o *FundPostRequest) GetFrom() string {
	if o == nil {
		var ret string
		return ret
	}

	return o.From
}

// GetFromOk returns a tuple with the From field value
// and a boolean to check if the value has been set.
func (o *FundPostRequest) GetFromOk() (*string, bool) {
	if o == nil {
		return nil, false
	}
	return &o.From, true
}

// SetFrom sets field value
func (o *FundPostRequest) SetFrom(v string) {
	o.From = v
}

// GetTo returns the To field value
func (o *FundPostRequest) GetTo() string {
	if o == nil {
		var ret string
		return ret
	}

	return o.To
}

// GetToOk returns a tuple with the To field value
// and a boolean to check if the value has been set.
func (o *FundPostRequest) GetToOk() (*string, bool) {
	if o == nil {
		return nil, false
	}
	return &o.To, true
}

// SetTo sets field value
func (o *FundPostRequest) SetTo(v string) {
	o.To = v
}

func (o FundPostRequest) MarshalJSON() ([]byte, error) {
	toSerialize,err := o.ToMap()
	if err != nil {
		return []byte{}, err
	}
	return json.Marshal(toSerialize)
}

func (o FundPostRequest) ToMap() (map[string]interface{}, error) {
	toSerialize := map[string]interface{}{}
	toSerialize["from"] = o.From
	toSerialize["to"] = o.To
	return toSerialize, nil
}

func (o *FundPostRequest) UnmarshalJSON(data []byte) (err error) {
	// This validates that all required properties are included in the JSON object
	// by unmarshalling the object into a generic map with string keys and checking
	// that every required field exists as a key in the generic map.
	requiredProperties := []string{
		"from",
		"to",
	}

	allProperties := make(map[string]interface{})

	err = json.Unmarshal(data, &allProperties)

	if err != nil {
		return err;
	}

	for _, requiredProperty := range(requiredProperties) {
		if _, exists := allProperties[requiredProperty]; !exists {
			return fmt.Errorf("no value given for required property %v", requiredProperty)
		}
	}

	varFundPostRequest := _FundPostRequest{}

	decoder := json.NewDecoder(bytes.NewReader(data))
	decoder.DisallowUnknownFields()
	err = decoder.Decode(&varFundPostRequest)

	if err != nil {
		return err
	}

	*o = FundPostRequest(varFundPostRequest)

	return err
}

type NullableFundPostRequest struct {
	value *FundPostRequest
	isSet bool
}

func (v NullableFundPostRequest) Get() *FundPostRequest {
	return v.value
}

func (v *NullableFundPostRequest) Set(val *FundPostRequest) {
	v.value = val
	v.isSet = true
}

func (v NullableFundPostRequest) IsSet() bool {
	return v.isSet
}

func (v *NullableFundPostRequest) Unset() {
	v.value = nil
	v.isSet = false
}

func NewNullableFundPostRequest(val *FundPostRequest) *NullableFundPostRequest {
	return &NullableFundPostRequest{value: val, isSet: true}
}

func (v NullableFundPostRequest) MarshalJSON() ([]byte, error) {
	return json.Marshal(v.value)
}

func (v *NullableFundPostRequest) UnmarshalJSON(src []byte) error {
	v.isSet = true
	return json.Unmarshal(src, &v.value)
}

