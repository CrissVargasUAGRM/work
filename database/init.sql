CREATE TABLE IF NOT EXISTS public."Product" (
	id serial4 NOT NULL,
	name text NOT NULL,
	price float8 NOT NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updateAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	tz_lock int4 DEFAULT 0 NOT NULL,
	CONSTRAINT "Product_pkey" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."User" (
	id serial4 NOT NULL,
	email text NOT NULL UNIQUE,
	name text NOT NULL,
	"password" text NOT NULL,
	CONSTRAINT "User_pkey" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."Order" (
	id text NOT NULL,
	"totalAmount" float8 NOT NULL,
	"totalItems" int4 NOT NULL,
	status text DEFAULT 'PENDING' NOT NULL,
	paid bool DEFAULT false NOT NULL,
	"paidAt" timestamp(3) NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp(3) NOT NULL,
	"stripeChargeId" text NULL,
	CONSTRAINT "Order_pkey" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."OrderItem" (
	id text NOT NULL,
	"productId" int4 NOT NULL,
	quantity int4 NOT NULL,
	price float8 NOT NULL,
	"orderId" text NULL,
	CONSTRAINT "OrderItem_pkey" PRIMARY KEY (id),
	CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS public."OrderReceipt" (
	id text NOT NULL,
	"orderId" text NOT NULL,
	"receiptUrl" text NOT NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp(3) NOT NULL,
	CONSTRAINT "OrderReceipt_pkey" PRIMARY KEY (id),
	CONSTRAINT "OrderReceipt_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);