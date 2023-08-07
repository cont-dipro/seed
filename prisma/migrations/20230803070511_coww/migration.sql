/*
  Warnings:

  - A unique constraint covering the columns `[accountId]` on the table `customers` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `accountId` to the `customers` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "customers" ADD COLUMN     "accountId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "customers_accountId_key" ON "customers"("accountId");
