# ProjectsGet200Response

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Transactions** | Pointer to [**[]Project**](Project.md) | The list of projects. | [optional] 

## Methods

### NewProjectsGet200Response

`func NewProjectsGet200Response() *ProjectsGet200Response`

NewProjectsGet200Response instantiates a new ProjectsGet200Response object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewProjectsGet200ResponseWithDefaults

`func NewProjectsGet200ResponseWithDefaults() *ProjectsGet200Response`

NewProjectsGet200ResponseWithDefaults instantiates a new ProjectsGet200Response object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetTransactions

`func (o *ProjectsGet200Response) GetTransactions() []Project`

GetTransactions returns the Transactions field if non-nil, zero value otherwise.

### GetTransactionsOk

`func (o *ProjectsGet200Response) GetTransactionsOk() (*[]Project, bool)`

GetTransactionsOk returns a tuple with the Transactions field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetTransactions

`func (o *ProjectsGet200Response) SetTransactions(v []Project)`

SetTransactions sets Transactions field to given value.

### HasTransactions

`func (o *ProjectsGet200Response) HasTransactions() bool`

HasTransactions returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


