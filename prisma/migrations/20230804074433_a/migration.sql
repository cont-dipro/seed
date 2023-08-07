/*
  Warnings:

  - The values [Inferiority,ContractClosing,Maintenance] on the enum `PurposeOfVisit` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `durationStayInMinutes` on the `customer_activity_logs` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `customer_activity_logs` table. All the data in the column will be lost.
  - You are about to drop the column `quantity` on the `customer_activity_logs` table. All the data in the column will be lost.
  - The `visitedTimes` column on the `customer_activity_logs` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `referenceSource` column on the `customers` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `customer_maintenance_logs` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "ReferenceSource" AS ENUM ('Homepage', 'KeywordSearch', 'OtherWebsites', 'Instagram', 'DirectStore', 'Introduction', 'Passing', 'Maintenance', 'Others');

-- CreateEnum
CREATE TYPE "VisitReason" AS ENUM ('Website', 'DirectAtStore', 'None');

-- CreateEnum
CREATE TYPE "WarrantyContent" AS ENUM ('ChangeSize', 'Refinish', 'RepairDiamond', 'Others');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "PaymentMethod" ADD VALUE 'Rakuten';
ALTER TYPE "PaymentMethod" ADD VALUE 'David';
ALTER TYPE "PaymentMethod" ADD VALUE 'JCB';
ALTER TYPE "PaymentMethod" ADD VALUE 'AMEX';
ALTER TYPE "PaymentMethod" ADD VALUE 'UC';
ALTER TYPE "PaymentMethod" ADD VALUE 'DC';
ALTER TYPE "PaymentMethod" ADD VALUE 'Diners';
ALTER TYPE "PaymentMethod" ADD VALUE 'Credit';
ALTER TYPE "PaymentMethod" ADD VALUE 'Others';

-- AlterEnum
BEGIN;
CREATE TYPE "PurposeOfVisit_new" AS ENUM ('Preview', 'CloseADeal', 'Warranty');
ALTER TABLE "customer_activity_logs" ALTER COLUMN "purposeOfVisit" TYPE "PurposeOfVisit_new" USING ("purposeOfVisit"::text::"PurposeOfVisit_new");
ALTER TYPE "PurposeOfVisit" RENAME TO "PurposeOfVisit_old";
ALTER TYPE "PurposeOfVisit_new" RENAME TO "PurposeOfVisit";
DROP TYPE "PurposeOfVisit_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "customer_maintenance_logs" DROP CONSTRAINT "customer_maintenance_logs_agencyId_fkey";

-- DropForeignKey
ALTER TABLE "customer_maintenance_logs" DROP CONSTRAINT "customer_maintenance_logs_customerId_fkey";

-- DropForeignKey
ALTER TABLE "customer_maintenance_logs" DROP CONSTRAINT "customer_maintenance_logs_orderId_fkey";

-- AlterTable
ALTER TABLE "customer_activity_logs" DROP COLUMN "durationStayInMinutes",
DROP COLUMN "email",
DROP COLUMN "quantity",
ADD COLUMN     "numberOfVisit" INTEGER,
ADD COLUMN     "serveTime" INTEGER,
ADD COLUMN     "visitDate" TIMESTAMP(3),
ALTER COLUMN "visitedAt" SET DATA TYPE TEXT,
DROP COLUMN "visitedTimes",
ADD COLUMN     "visitedTimes" INTEGER;

-- AlterTable
ALTER TABLE "customers" ADD COLUMN     "visitReason" "VisitReason",
DROP COLUMN "referenceSource",
ADD COLUMN     "referenceSource" "ReferenceSource";

-- DropTable
DROP TABLE "customer_maintenance_logs";

-- DropEnum
DROP TYPE "MaintenanceContent";

-- CreateTable
CREATE TABLE "customer_warranty_logs" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "customerId" INTEGER NOT NULL,
    "orderCode" TEXT NOT NULL,
    "agencyId" INTEGER NOT NULL,
    "dateOfReceive" TIMESTAMP(3) NOT NULL,
    "dateExpectedDelivery" TIMESTAMP(3),
    "dateDoneDelivery" TIMESTAMP(3),
    "warrantyContent" "WarrantyContent",
    "dateShipment" TIMESTAMP(3),
    "informationDetail" TEXT,
    "saleAmount" INTEGER,
    "paymentDay" TIMESTAMP(3),
    "paymentMethod" "PaymentMethod",
    "completionContact" TEXT,
    "staffName" TEXT,

    CONSTRAINT "customer_warranty_logs_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "customer_warranty_logs" ADD CONSTRAINT "customer_warranty_logs_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_warranty_logs" ADD CONSTRAINT "customer_warranty_logs_agencyId_fkey" FOREIGN KEY ("agencyId") REFERENCES "agencies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_warranty_logs" ADD CONSTRAINT "customer_warranty_logs_orderCode_fkey" FOREIGN KEY ("orderCode") REFERENCES "orders"("orderCode") ON DELETE CASCADE ON UPDATE CASCADE;
