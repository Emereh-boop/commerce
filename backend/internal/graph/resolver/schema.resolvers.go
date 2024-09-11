package resolver

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.
// Code generated by github.com/99designs/gqlgen version v0.17.49

import (
	"context"
	"errors"
	"log"

	"github.com/jackc/pgx/v5/pgtype"
	auth "github.com/petrejonn/naytife/internal"
	"github.com/petrejonn/naytife/internal/db"
	"github.com/petrejonn/naytife/internal/graph/generated"
	"github.com/petrejonn/naytife/internal/graph/model"
)

// SignInUser is the resolver for the signInUser field.
func (r *mutationResolver) SignInUser(ctx context.Context, input model.SignInInput) (*model.SignInUserPayload, error) {
	// Retrieve the user claims from the context
	claims, ok := ctx.Value("userClaims").(*auth.CustomClaims)
	if !ok {
		return nil, errors.New("Unauthorized")
	}
	// Log the extracted claims for debugging
	log.Printf("User claims: %+v", claims)

	// Check if the user exists in the database
	user, err := r.Repository.UpsertUser(ctx, db.UpsertUserParams{
		Auth0Sub: pgtype.Text{String: claims.Sub, Valid: true},
		Email:    claims.Email,
		Name: pgtype.Text{
			String: claims.Name,
			Valid:  true},
		ProfilePictureUrl: pgtype.Text{String: claims.ProfilePictureURL, Valid: true},
	})
	if err != nil {
		return nil, errors.New("user not found")
	}
	// Return the user data and a JWT token
	return &model.SignInUserPayload{
		Successful: true,
		User: &model.User{
			ID:                user.UserID.String(),
			Email:             user.Email,
			Name:              &user.Name.String,
			ProfilePictureURL: &user.ProfilePictureUrl.String,
		},
	}, nil
}

// Node is the resolver for the node field.
func (r *queryResolver) Node(ctx context.Context, id string) (model.Node, error) {
	typ, localID, err := fromGlobalID(id)
	if err != nil {
		return nil, err
	}
	log.Println(localID)

	switch typ {
	// case "Shop":
	// 	return r.Resolver.GetShopByID(ctx, localID)
	// case "Product":
	// 	return r.Resolver.GetProductByID(ctx, localID)
	default:
		return nil, errors.New("unknown node type")
	}
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

// Query returns generated.QueryResolver implementation.
func (r *Resolver) Query() generated.QueryResolver { return &queryResolver{r} }

type mutationResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }
