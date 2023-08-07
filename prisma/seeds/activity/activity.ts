import { CustomerActivityLog } from "@prisma/client";

const reader = require('xlsx')
const file = reader.readFile('D:\\prisma-express\\prisma\\seeds\\activity\\activelog.xlsx')

const formatTime = (serialNumber: number) => {
  if (!serialNumber) {
    return
  }
  const date = new Date((serialNumber - 25569) * 86400 * 1000);
  return date.toISOString()
}

const formatT = (timeValue: number) => {
  if (!timeValue) {
    return "";
  }
  const hours = Math.floor(timeValue * 24);
  const minutes = Math.floor((timeValue * 24 - hours) * 60);

  const timeString = hours.toString().padStart(2, '0') + ':' + minutes.toString().padStart(2, '0');
  return timeString;
}

const convertNumber = (str: string) => {
  try {
    const a = str.match(/\d+/);
    return a ? +a[0] : null
  }
  catch (e) {
    console.log(str);
  }
}

const dataActives: any = []
const sheets = file.SheetNames
for (let i = 0; i < sheets.length; i++) {
  const temp = reader.utils.sheet_to_json(
    file.Sheets[file.SheetNames[i]])
  let aaa = 0;
  temp.forEach((res: any) => {
    dataActives.push({
      createdAt: res.CREATEDDATE,
      updatedAt: new Date().toISOString(),
      customerId: res.customerId,
      agencyId: 1,
      staffName: res.staffName,
      serveTime: null,
      numberOfVisit: res.quantity,
      visitedTimes: null,
      visitDate: null,
      visitedDayOfWeek: null,
      visitedAt: formatTime(res.visitedAt),
      purposeOfVisit: null,
      isRegistrationMemberVisit: null,
      note: res.note,
    })
  })
}

export default dataActives;
