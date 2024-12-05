package block

import (
	"context"
	"fmt"

	"github.com/sashabaranov/go-openai"
)

func generateMessage(apiKey string) (string, error) {
	client := openai.NewClient(apiKey)
	req := openai.ChatCompletionRequest{
		Model: openai.GPT4oMini,
		Messages: []openai.ChatCompletionMessage{
			{
				Role:    openai.ChatMessageRoleSystem,
				Content: "You are a peom generator. Please generate a random poem in English.",
			},
		},
	}
	resp, err := client.CreateChatCompletion(context.Background(), req)

	if err != nil {
		fmt.Printf("Chat Error: %v", err)
		return "", err
	}

	if len(resp.Choices) > 0 {
		return resp.Choices[0].Message.Content, nil
	}

	return "", nil
}
