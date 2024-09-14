CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),           
    auth0_sub VARCHAR(255) UNIQUE,        
    email VARCHAR(255) NOT NULL,          
    name VARCHAR(255),                    
    profile_picture_url TEXT,             
    created_at TIMESTAMP DEFAULT NOW(),   
    last_login TIMESTAMP                  
);

CREATE TABLE shops (
    shop_id BIGSERIAL PRIMARY KEY,
    owner_id UUID NOT NULL,
    title VARCHAR(50) NOT NULL,
    default_domain VARCHAR(50) UNIQUE NOT NULL CHECK (default_domain LIKE '%.%'),
    favicon_url TEXT,
    logo_url TEXT,
    email VARCHAR(50) NOT NULL,
    currency_code VARCHAR(3) NOT NULL,
    status VARCHAR(10) NOT NULL,
    about TEXT,
    address TEXT,
    phone_number VARCHAR(15),
    seo_description TEXT,
    seo_keywords TEXT[],
    seo_title VARCHAR(255),
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES users(user_id) 
);

CREATE TABLE whatsapps (
    whatsapp_id BIGSERIAL PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL,
    country_code VARCHAR(5) NOT NULL,
    url TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    shop_id BIGINT NOT NULL,
    CONSTRAINT fk_shop FOREIGN KEY (shop_id) REFERENCES shops(shop_id)
);

CREATE TABLE categories (
    category_id BIGSERIAL PRIMARY KEY,
    slug VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    parent_id BIGINT,
    category_attributes JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    shop_id BIGINT NOT NULL,
    UNIQUE (title, shop_id),
    UNIQUE (slug, shop_id),
    CONSTRAINT fk_parent FOREIGN KEY (parent_id) REFERENCES categories(category_id),
    CONSTRAINT fk_shop FOREIGN KEY (shop_id) REFERENCES shops(shop_id)
);