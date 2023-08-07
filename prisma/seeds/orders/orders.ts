import { CustomerWarrantyLog, Order, PaymentMethod } from '@prisma/client';
import * as lodash from 'lodash';

const reader = require('xlsx')
const file = reader.readFile('D:\\prisma-express\\prisma\\seeds\\orders\\order.xlsx')


const aaa = (str: string) => {
  switch (str) {
    case '振込': {
      return PaymentMethod.Transfer;
    }
    case '現金': {
      return PaymentMethod.Cash;
    }
    case 'JCB': {
      return PaymentMethod.JCB;
    }
    case 'デビッド': {
      return PaymentMethod.David;
    }
    case 'UC': {
      return PaymentMethod.UC;
    }
    case 'DC': {
      return PaymentMethod.DC
    }
    case 'その他': {
      return PaymentMethod.Others
    }
    default: {
      return null;
    }
  }
}

const dataOrders: any = []
const sheets = file.SheetNames
for (let i = 0; i < sheets.length; i++) {
  const temp = reader.utils.sheet_to_json(
    file.Sheets[file.SheetNames[i]])
  temp.forEach((res: any) => {
    // if (!res.orderCode) {
    //   return;
    // }
    
    dataOrders.push({
      createdAt: res.CREATEDDATE,
      updatedAt: new Date().toISOString(),
      orderCode: res.NAME,
      customerId: res.accountId,
      agencyId: 1,
      value: null,
      paymentMethodFirstTime: aaa(res.first),
      paymentMethodSecondTime: aaa(res.second),
      paidAmountFirstTime: null,
      paidAmountFirstTimeDate: null,
      paidAmountSecondTime: null,
      paidAmountSecondTimeDate: null,
      accountBalance: null,
      date: null,
      deliveryDate: null,
      size: null,
      price: null,
      productId: null
    })
  })
}

export default dataOrders;
