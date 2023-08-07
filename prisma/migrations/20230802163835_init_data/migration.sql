-- CreateEnum
CREATE TYPE "Role" AS ENUM ('Employee', 'Admin', 'SuperAdmin');

-- CreateEnum
CREATE TYPE "PurposeOfUse" AS ENUM ('Engagement', 'Wedding', 'Anniversary');

-- CreateEnum
CREATE TYPE "ConsideredBrand" AS ENUM ('Niessing', 'FullerJaco', 'Fisher', 'Meister', 'Boucheron', 'Tiffany');

-- CreateEnum
CREATE TYPE "StoreType" AS ENUM ('Agency', 'DirectStore');

-- CreateEnum
CREATE TYPE "DayOfWeek" AS ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- CreateEnum
CREATE TYPE "ProductType" AS ENUM ('Gold', 'Diamond');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('Cash', 'Transfer');

-- CreateEnum
CREATE TYPE "DiamondStyle" AS ENUM ('Square', 'Rounded');

-- CreateEnum
CREATE TYPE "DiamondPosition" AS ENUM ('Middle', 'Bottom');

-- CreateEnum
CREATE TYPE "LinePosition" AS ENUM ('Middle', 'Bottom');

-- CreateEnum
CREATE TYPE "FontFamily" AS ENUM ('TimeNewRoman', 'Aria');

-- CreateEnum
CREATE TYPE "Owner" AS ENUM ('Main', 'Fiance');

-- CreateEnum
CREATE TYPE "MaintenanceContent" AS ENUM ('ChangeSize', 'Refinish', 'RepairDiamond', 'Others');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "emailVerifiedAt" TIMESTAMP(3),
    "image" TEXT,
    "role" "Role" NOT NULL DEFAULT 'Admin',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "token" TEXT NOT NULL,
    "agencyId" INTEGER,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "agencies" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT,
    "storeType" "StoreType" NOT NULL,

    CONSTRAINT "agencies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customers" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "surName" TEXT NOT NULL,
    "name" TEXT,
    "furigana" TEXT,
    "sizeA" TEXT,
    "sizeB" TEXT,
    "agencyId" INTEGER NOT NULL,
    "birthday" DATE,
    "closedDeal" BOOLEAN,
    "scheduleWeddingDate" DATE,
    "engagementRegistrationDate" DATE,
    "staffName" TEXT,
    "phone" TEXT,
    "email" TEXT,
    "addressUpdatedDate" DATE,
    "postalCode" TEXT,
    "address" TEXT,
    "newPostalCode" TEXT,
    "newAddress" TEXT,
    "purposeOfUse" "PurposeOfUse",
    "consideredBrand" "ConsideredBrand",
    "referenceSource" TEXT,
    "contractDate" DATE,
    "fianceName" TEXT,
    "fianceFurigana" TEXT,
    "fianceAddress" TEXT,
    "fianceSizeA" TEXT,
    "fianceSizeB" TEXT,
    "fiancePhone" TEXT,
    "fianceEmail" TEXT,
    "note" TEXT,

    CONSTRAINT "customers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_activity_logs" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "quantity" INTEGER,
    "visitedAt" TIMESTAMP(3),
    "visitedDayOfWeek" "DayOfWeek",
    "visitedTimes" INTEGER,
    "durationStayInMinutes" INTEGER,
    "customerId" INTEGER,
    "agencyId" INTEGER,
    "purpose" TEXT,
    "email" TEXT,
    "staffName" TEXT,
    "isRegistrationMemberVisit" BOOLEAN DEFAULT false,
    "note" TEXT,

    CONSTRAINT "customer_activity_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT,
    "image" TEXT,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "categoryId" INTEGER,
    "name" TEXT,
    "image" TEXT,
    "partNumber" TEXT,
    "barCode" TEXT,
    "sculptureContent" TEXT,
    "singleColor" TEXT,
    "redColor" TEXT,
    "grayColor" TEXT,
    "roseColor" TEXT,
    "yellowColor" TEXT,
    "platinumColor" TEXT,
    "productType" "ProductType" NOT NULL,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderCode" TEXT NOT NULL,
    "customerId" INTEGER,
    "agencyId" INTEGER,
    "value" INTEGER,
    "paymentMethodFirstTime" "PaymentMethod",
    "paymentMethodSecondTime" "PaymentMethod",
    "paidAmountFirstTime" INTEGER,
    "paidAmountFirstTimeDate" DATE,
    "paidAmountSecondTime" INTEGER,
    "paidAmountSecondTimeDate" DATE,
    "accountBalance" INTEGER,
    "date" DATE,
    "deliveryDate" DATE,
    "size" INTEGER,
    "price" INTEGER,
    "productId" INTEGER,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_details" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderId" INTEGER,
    "owner" "Owner" NOT NULL,
    "diamondStyle" "DiamondStyle",
    "diamondPosition" "DiamondPosition",
    "linePosition" "LinePosition",
    "fontFamily" "FontFamily" NOT NULL,
    "sculptureText" TEXT,
    "combineColorNote" TEXT,
    "note" TEXT,

    CONSTRAINT "order_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_maintenance_logs" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "customerId" INTEGER NOT NULL,
    "agencyId" INTEGER NOT NULL,
    "orderCode" TEXT NOT NULL,
    "dateOfReceive" TIMESTAMP(3) NOT NULL,
    "dateExpectedDelivery" TIMESTAMP(3),
    "dateDoneDelivery" TIMESTAMP(3),
    "maintenanceContent" "MaintenanceContent",
    "dateShipment" TIMESTAMP(3),
    "informationDetail" TEXT,
    "saleAmount" INTEGER,
    "paymentDay" TIMESTAMP(3),
    "paymentMethod" TEXT,
    "completionContact" TEXT,

    CONSTRAINT "customer_maintenance_logs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_token_key" ON "users"("token");

-- CreateIndex
CREATE UNIQUE INDEX "products_id_key" ON "products"("id");

-- CreateIndex
CREATE UNIQUE INDEX "orders_orderCode_key" ON "orders"("orderCode");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_agencyId_fkey" FOREIGN KEY ("agencyId") REFERENCES "agencies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customers" ADD CONSTRAINT "customers_agencyId_fkey" FOREIGN KEY ("agencyId") REFERENCES "agencies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_activity_logs" ADD CONSTRAINT "customer_activity_logs_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_activity_logs" ADD CONSTRAINT "customer_activity_logs_agencyId_fkey" FOREIGN KEY ("agencyId") REFERENCES "agencies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_agencyId_fkey" FOREIGN KEY ("agencyId") REFERENCES "agencies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_details" ADD CONSTRAINT "order_details_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_maintenance_logs" ADD CONSTRAINT "customer_maintenance_logs_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_maintenance_logs" ADD CONSTRAINT "customer_maintenance_logs_agencyId_fkey" FOREIGN KEY ("agencyId") REFERENCES "agencies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_maintenance_logs" ADD CONSTRAINT "customer_maintenance_logs_orderCode_fkey" FOREIGN KEY ("orderCode") REFERENCES "orders"("orderCode") ON DELETE RESTRICT ON UPDATE CASCADE;
