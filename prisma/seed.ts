import { PrismaClient } from '@prisma/client';
import * as lodash from 'lodash';
import { agencies } from './seeds/agencies';
import dataActives from './seeds/activity/activity';
import dataMaintenances from './seeds/maintenance/maintenance';
import dataCustomers from './seeds/customer/customer';
import dataOrders from './seeds/orders/orders';
const prisma = new PrismaClient();

async function main() {
  for (let agency of agencies) {
    await prisma.agency.upsert({
      create: agency,
      update: agency,
      where: {
        id: agency.id,
      }
    });
  }

  await prisma.customer.createMany({
    data: dataCustomers
  })

  const customers = await prisma.customer.findMany();

  const orders = []

  for (let i = 0; i < dataOrders.length; i++) {
    const index = customers.findIndex((item) => item.accountId === dataOrders[i].customerId)
    if (index !== -1) {
      orders.push({
        ...dataOrders[i],
        customerId: customers[index].id
      })
    }
  }
  await prisma.order.createMany({
    data: orders
  })

  const orderss = await prisma.order.findMany();

  const dataWarranties = []
  for (let i = 0; i < dataMaintenances.length; i++) {
    const index = customers.findIndex((item) => item.accountId === dataMaintenances[i].customerId)
    const index2 = orderss.findIndex((item) => item.orderCode === dataMaintenances[i].orderId)
    if (index !== -1 && index2 !== -1) {
      dataWarranties.push({
        ...dataMaintenances[i],
        customerId: customers[index].id,
        orderId: orderss[index].id
      })
    }
  }
  await prisma.customerWarrantyLog.createMany({
    data: dataWarranties
  })

  const dataAcitvities = []
  for (let i = 0; i < dataActives.length; i++) {
    const index = customers.findIndex((item) => item.accountId === dataActives[i].customerId)
    if (index !== -1) {
      dataAcitvities.push({
        ...dataActives[i],
        customerId: customers[index].id
      })
    }
  }
  await prisma.customerActivityLog.createMany({
    data: dataAcitvities
  })



}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
