/*
  Warnings:

  - You are about to drop the column `orderCode` on the `customer_warranty_logs` table. All the data in the column will be lost.
  - Added the required column `orderId` to the `customer_warranty_logs` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "customer_warranty_logs" DROP CONSTRAINT "customer_warranty_logs_orderCode_fkey";

-- DropIndex
DROP INDEX "customers_accountId_key";

-- DropIndex
DROP INDEX "orders_orderCode_key";

-- AlterTable
ALTER TABLE "customer_warranty_logs" DROP COLUMN "orderCode",
ADD COLUMN     "orderId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "customers" ALTER COLUMN "accountId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "orders" ALTER COLUMN "orderCode" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "customer_warranty_logs" ADD CONSTRAINT "customer_warranty_logs_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;
