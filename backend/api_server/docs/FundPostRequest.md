# FundPostRequest

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**From** | **string** | User wallet address | 
**To** | **string** | Project wallet address | 

## Methods

### NewFundPostRequest

`func NewFundPostRequest(from string, to string, ) *FundPostRequest`

NewFundPostRequest instantiates a new FundPostRequest object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewFundPostRequestWithDefaults

`func NewFundPostRequestWithDefaults() *FundPostRequest`

NewFundPostRequestWithDefaults instantiates a new FundPostRequest object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetFrom

`func (o *FundPostRequest) GetFrom() string`

GetFrom returns the From field if non-nil, zero value otherwise.

### GetFromOk

`func (o *FundPostRequest) GetFromOk() (*string, bool)`

GetFromOk returns a tuple with the From field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetFrom

`func (o *FundPostRequest) SetFrom(v string)`

SetFrom sets From field to given value.


### GetTo

`func (o *FundPostRequest) GetTo() string`

GetTo returns the To field if non-nil, zero value otherwise.

### GetToOk

`func (o *FundPostRequest) GetToOk() (*string, bool)`

GetToOk returns a tuple with the To field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetTo

`func (o *FundPostRequest) SetTo(v string)`

SetTo sets To field to given value.



[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


