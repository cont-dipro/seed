/*
  Warnings:

  - You are about to drop the column `purpose` on the `customer_activity_logs` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "PurposeOfVisit" AS ENUM ('Inferiority', 'ContractClosing', 'Maintenance');

-- DropForeignKey
ALTER TABLE "customer_maintenance_logs" DROP CONSTRAINT "customer_maintenance_logs_orderCode_fkey";

-- AlterTable
ALTER TABLE "customer_activity_logs" DROP COLUMN "purpose",
ADD COLUMN     "purposeOfVisit" "PurposeOfVisit";

-- AlterTable
ALTER TABLE "customer_maintenance_logs" ADD COLUMN     "orderId" INTEGER,
ADD COLUMN     "staffName" TEXT;

-- AddForeignKey
ALTER TABLE "customer_maintenance_logs" ADD CONSTRAINT "customer_maintenance_logs_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE SET NULL ON UPDATE CASCADE;
