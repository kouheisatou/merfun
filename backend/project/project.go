package project

import "time"

type Project struct {
	projectID      string
	Name           string
	Description    string
	currentAmount  float32
	CreatorAddress string
	timeStamp      int64
}

type ProjectRequest struct {
	Name        *string `json:"name"`
	Description *string `json:"description"`
}
type ProjectResponse struct {
	Name           *string `json:"name"`
	Description    *string `json:"description"`
	ProjectAddress *string `json:"project_address"`
}

func NewProject(projectID, name, creatorAddress string, description string) *Project {
	return &Project{
		projectID:      projectID,
		Name:           name,
		Description:    description,
		currentAmount:  0.0,
		CreatorAddress: creatorAddress,
		timeStamp:      time.Now().UnixNano(),
	}
}

func (p *ProjectRequest) Validate() bool {
	if p.Description == nil || p.Name == nil {

		return false

	}
	return true
}
