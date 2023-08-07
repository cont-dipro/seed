


const reader = require('xlsx')
const file = reader.readFile('D:\\prisma-express\\prisma\\seeds\\customer\\customer.xlsx')

let dataCustomers: any = []

const sheets = file.SheetNames
for (let i = 0; i < sheets.length; i++) {
  const temp = reader.utils.sheet_to_json(
    file.Sheets[file.SheetNames[i]])
  temp.forEach((res: any) => {
    if (res.BIRTHDATE == false) {
      return;
    }
    if (res.ACCOUNTID[0] != '0') {
      return;
    }
    dataCustomers.push({
      createdAt: (new Date(res.CREATEDDATE)).toString() != 'Invalid Date' ? new Date(res.CREATEDDATE).toISOString() : new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      accountId: res.ACCOUNTID,
      surName: res.FIRSTNAME || '',
      name: res.NAME ? "" + res.NAME : undefined,
      furigana: null,
      sizeA: null,
      sizeB: null,
      agencyId: 1,
      birthday: null,
      closedDeal: null,
      scheduleWeddingDate: null,
      engagementRegistrationDate: null,
      staffName: null,
      phone: res.MOBILEPHONE ? "" + res.MOBILEPHONE : undefined,
      email: res.EMAIL,
      addressUpdatedDate: null,
      postalCode: null,
      address: null,
      newPostalCode: null,
      newAddress: null,
      purposeOfUse: null,
      consideredBrand: null,
      referenceSource: null,
      contractDate: null,
      fianceName: res.MAILINGPOSTALCODE ? "" + res.MAILINGPOSTALCODE : undefined,
      fianceFurigana: null,
      fianceAddress: null,
      fianceSizeA: null,
      fianceSizeB: null,
      fiancePhone: res.MAILINGLONGITUDE ? "" + res.MAILINGLONGITUDE : undefined,
      fianceEmail: null,
      note: res.DESCRIPTION ? "" + res.DESCRIPTION : undefined,
    })
  })
}

export default dataCustomers
