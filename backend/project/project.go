package project

import "time"

type Project struct {
	projectID      string
	name           string
	description    string
	currentAmount  float32
	creatorAddress string
	timeStamp      int64
}

type ProjectRequest struct {
	Name        *string `json:"name"`
	Description *string `json:"description"`
}

func NewProject(projectID, name, creatorAddress string, description string) *Project {
	return &Project{
		projectID:      projectID,
		name:           name,
		description:    description,
		currentAmount:  0.0,
		creatorAddress: creatorAddress,
		timeStamp:      time.Now().UnixNano(),
	}
}

func (p *ProjectRequest) Validate() bool {
	if p.Description == nil || p.Name == nil {

		return false

	}
	return true
}
