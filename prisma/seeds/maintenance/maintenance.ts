import { CustomerWarrantyLog } from '@prisma/client';
import * as lodash from 'lodash';

const reader = require('xlsx')
const file = reader.readFile('D:\\prisma-express\\prisma\\seeds\\maintenance\\mantaince.xlsx')


const dataMaintenances: any = []
const sheets = file.SheetNames
for (let i = 0; i < sheets.length; i++) {
  const temp = reader.utils.sheet_to_json(
    file.Sheets[file.SheetNames[i]])
  let aaa = 0;
  temp.forEach((res: any) => {
    if (!res.orderCode) {
      return;
    }
    dataMaintenances.push({
      createdAt: res.CREATEDDATE,
      updatedAt: new Date().toISOString(),
      customerId: res.customerId,
      agencyId: 1,
      
      // orderId: 1,
      orderId: "" + res.orderCode,
      dateOfReceive: new Date().toISOString(),
      dateExpectedDelivery: null,
      dateDoneDelivery: null,
      //check
      warrantyContent: "Refinish",
      dateShipment: null,
      informationDetail: res.informationDetail,
      saleAmount: 0,
      paymentDay: null,

      // paymentMethod: res.paymentMethod,
      paymentMethod: null,

      completionContact: "" + res.completionContact,
      staffName: res.staffName
    })
  })
}

export default dataMaintenances;
