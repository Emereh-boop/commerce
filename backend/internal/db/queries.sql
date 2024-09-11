-- name: UpsertUser :one
INSERT INTO users (auth0_sub, email, name, profile_picture_url)
VALUES ($1, $2, $3, $4)
ON CONFLICT (auth0_sub)
DO UPDATE SET email = EXCLUDED.email, name = EXCLUDED.name, profile_picture_url = EXCLUDED.profile_picture_url
RETURNING user_id, auth0_sub, email, name, profile_picture_url;

-- name: GetUser :one
SELECT * FROM users
WHERE auth0_sub = $1;

-- name: CreateShop :one
INSERT INTO shops (owner_id, title, default_domain, favicon_url,logo_url,email, currency_code, about, status, address,phone_number, seo_description, seo_keywords, seo_title)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
RETURNING *;

-- name: GetShop :one
SELECT * FROM shops
WHERE shop_id = $1;

-- name: GetShopsByOwner :many
SELECT * FROM shops
WHERE owner_id = $1;

-- name: UpdateShop :one
UPDATE shops
SET 
    title = COALESCE(sqlc.narg('title'), title),
    favicon_url = COALESCE(sqlc.narg('favicon_url'), favicon_url),
    currency_code = COALESCE(sqlc.narg('currency_code'), currency_code),
    about = COALESCE(sqlc.narg('about'), about),
    status = COALESCE(sqlc.narg('status'), status),
    phone_number = COALESCE(sqlc.narg('phone_number'), phone_number),
    seo_description = COALESCE(sqlc.narg('seo_description'), seo_description),
    seo_keywords = COALESCE(sqlc.narg('seo_keywords'), seo_keywords),
    seo_title = COALESCE(sqlc.narg('seo_title'), seo_title),
    address = COALESCE(sqlc.narg('address'), address),
    email = COALESCE(sqlc.narg('email'), email)
WHERE default_domain = sqlc.arg('default_domain')
RETURNING *;

-- name: DeleteShop :exec
DELETE FROM shops
WHERE shop_id = $1;

-- name: GetShopByDomain :one
SELECT * FROM shops
WHERE default_domain = $1;

-- name: GetWhatsappsByShop :many
SELECT * FROM whatsapps
WHERE shop_id = $1;
