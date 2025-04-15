// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/invoice.dart';
import 'models/invoice_item.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 1672983046465597673),
      name: 'Invoice',
      lastPropertyId: const obx_int.IdUid(29, 2508087491037836745),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 3890450179426364889),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6865772874563358292),
            name: 'invoiceNo',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 9191885829780781509),
            name: 'date',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 4228676430908737861),
            name: 'companyName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 4783372659865723367),
            name: 'address',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4762333585076775615),
            name: 'gstNumber',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 5882257973261177415),
            name: 'panNumber',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 7518775087771973313),
            name: 'stateCode',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 5107038754376229363),
            name: 'billTaker',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 5708073310102450734),
            name: 'billTakerAddress',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(11, 3839464879353333506),
            name: 'billTakerGSTPin',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(12, 4600010460398069013),
            name: 'deliveryFirm',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(13, 3012722547490749159),
            name: 'deliveryFirmAddress',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(14, 4429756325963036195),
            name: 'deliveryFirmGSTPin',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(15, 6473165531744905281),
            name: 'broker',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(16, 8899578811471115002),
            name: 'discount',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(17, 7854756287243316062),
            name: 'othLess',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(18, 8756370834084617573),
            name: 'freight',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(19, 5695355691560927563),
            name: 'iGst',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(20, 248900858212115582),
            name: 'sGst',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(21, 4893950793228913829),
            name: 'cGst',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(22, 4125794333757904567),
            name: 'bankName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(23, 3167655237790876470),
            name: 'bankBranch',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(24, 8686299434915302807),
            name: 'bankAccountNo',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(25, 3201465326323911375),
            name: 'bankIFSCCode',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(26, 5425372191135784770),
            name: 'remark',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(27, 1736394768535198769),
            name: 'mobileNo',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(28, 1484988344574880309),
            name: 'billTakerMobileNo',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(29, 2508087491037836745),
            name: 'deliveryFirmMobileNo',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'items', srcEntity: 'InvoiceItem', srcField: '')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 443783049247010191),
      name: 'InvoiceItem',
      lastPropertyId: const obx_int.IdUid(8, 7623447192604980631),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8917307149150204895),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6642355817336750266),
            name: 'chalan',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 6822236859265026829),
            name: 'itemName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 6339038936042033449),
            name: 'taka',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 3453200907485504967),
            name: 'qty',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 468489216079176211),
            name: 'rate',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 315890099470973849),
            name: 'invoiceId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(1, 412286871668380978),
            relationTarget: 'Invoice'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 7623447192604980631),
            name: 'hsnCode',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(2, 443783049247010191),
      lastIndexId: const obx_int.IdUid(1, 412286871668380978),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Invoice: obx_int.EntityDefinition<Invoice>(
        model: _entities[0],
        toOneRelations: (Invoice object) => [],
        toManyRelations: (Invoice object) => {
              obx_int.RelInfo<InvoiceItem>.toOneBacklink(7, object.id,
                  (InvoiceItem srcObject) => srcObject.invoice): object.items
            },
        getId: (Invoice object) => object.id,
        setId: (Invoice object, int id) {
          object.id = id;
        },
        objectToFB: (Invoice object, fb.Builder fbb) {
          final invoiceNoOffset = fbb.writeString(object.invoiceNo);
          final dateOffset = fbb.writeString(object.date);
          final companyNameOffset = fbb.writeString(object.companyName);
          final addressOffset = fbb.writeString(object.address);
          final gstNumberOffset = fbb.writeString(object.gstNumber);
          final panNumberOffset = fbb.writeString(object.panNumber);
          final stateCodeOffset = fbb.writeString(object.stateCode);
          final billTakerOffset = fbb.writeString(object.billTaker);
          final billTakerAddressOffset =
              fbb.writeString(object.billTakerAddress);
          final billTakerGSTPinOffset = fbb.writeString(object.billTakerGSTPin);
          final deliveryFirmOffset = fbb.writeString(object.deliveryFirm);
          final deliveryFirmAddressOffset =
              fbb.writeString(object.deliveryFirmAddress);
          final deliveryFirmGSTPinOffset =
              fbb.writeString(object.deliveryFirmGSTPin);
          final brokerOffset = fbb.writeString(object.broker);
          final discountOffset = fbb.writeString(object.discount);
          final othLessOffset = fbb.writeString(object.othLess);
          final freightOffset = fbb.writeString(object.freight);
          final iGstOffset = fbb.writeString(object.iGst);
          final sGstOffset = fbb.writeString(object.sGst);
          final cGstOffset = fbb.writeString(object.cGst);
          final bankNameOffset = fbb.writeString(object.bankName);
          final bankBranchOffset = fbb.writeString(object.bankBranch);
          final bankAccountNoOffset = fbb.writeString(object.bankAccountNo);
          final bankIFSCCodeOffset = fbb.writeString(object.bankIFSCCode);
          final remarkOffset = fbb.writeString(object.remark);
          final mobileNoOffset = fbb.writeString(object.mobileNo);
          final billTakerMobileNoOffset =
              fbb.writeString(object.billTakerMobileNo);
          final deliveryFirmMobileNoOffset =
              fbb.writeString(object.deliveryFirmMobileNo);
          fbb.startTable(30);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, invoiceNoOffset);
          fbb.addOffset(2, dateOffset);
          fbb.addOffset(3, companyNameOffset);
          fbb.addOffset(4, addressOffset);
          fbb.addOffset(5, gstNumberOffset);
          fbb.addOffset(6, panNumberOffset);
          fbb.addOffset(7, stateCodeOffset);
          fbb.addOffset(8, billTakerOffset);
          fbb.addOffset(9, billTakerAddressOffset);
          fbb.addOffset(10, billTakerGSTPinOffset);
          fbb.addOffset(11, deliveryFirmOffset);
          fbb.addOffset(12, deliveryFirmAddressOffset);
          fbb.addOffset(13, deliveryFirmGSTPinOffset);
          fbb.addOffset(14, brokerOffset);
          fbb.addOffset(15, discountOffset);
          fbb.addOffset(16, othLessOffset);
          fbb.addOffset(17, freightOffset);
          fbb.addOffset(18, iGstOffset);
          fbb.addOffset(19, sGstOffset);
          fbb.addOffset(20, cGstOffset);
          fbb.addOffset(21, bankNameOffset);
          fbb.addOffset(22, bankBranchOffset);
          fbb.addOffset(23, bankAccountNoOffset);
          fbb.addOffset(24, bankIFSCCodeOffset);
          fbb.addOffset(25, remarkOffset);
          fbb.addOffset(26, mobileNoOffset);
          fbb.addOffset(27, billTakerMobileNoOffset);
          fbb.addOffset(28, deliveryFirmMobileNoOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final companyNameParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, '');
          final addressParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final mobileNoParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 56, '');
          final gstNumberParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final panNumberParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 16, '');
          final stateCodeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 18, '');
          final invoiceNoParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final dateParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final billTakerParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 20, '');
          final billTakerAddressParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 22, '');
          final billTakerMobileNoParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 58, '');
          final billTakerGSTPinParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 24, '');
          final deliveryFirmParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 26, '');
          final deliveryFirmAddressParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 28, '');
          final deliveryFirmMobileNoParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 60, '');
          final deliveryFirmGSTPinParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 30, '');
          final brokerParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 32, '');
          final bankNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 46, '');
          final bankBranchParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 48, '');
          final bankAccountNoParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 50, '');
          final bankIFSCCodeParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 52, '');
          final remarkParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 54, '');
          final discountParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 34, '');
          final othLessParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 36, '');
          final freightParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 38, '');
          final iGstParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 40, '');
          final sGstParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 42, '');
          final cGstParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 44, '');
          final object = Invoice(
              companyName: companyNameParam,
              address: addressParam,
              mobileNo: mobileNoParam,
              gstNumber: gstNumberParam,
              panNumber: panNumberParam,
              stateCode: stateCodeParam,
              invoiceNo: invoiceNoParam,
              date: dateParam,
              billTaker: billTakerParam,
              billTakerAddress: billTakerAddressParam,
              billTakerMobileNo: billTakerMobileNoParam,
              billTakerGSTPin: billTakerGSTPinParam,
              deliveryFirm: deliveryFirmParam,
              deliveryFirmAddress: deliveryFirmAddressParam,
              deliveryFirmMobileNo: deliveryFirmMobileNoParam,
              deliveryFirmGSTPin: deliveryFirmGSTPinParam,
              broker: brokerParam,
              bankName: bankNameParam,
              bankBranch: bankBranchParam,
              bankAccountNo: bankAccountNoParam,
              bankIFSCCode: bankIFSCCodeParam,
              remark: remarkParam,
              discount: discountParam,
              othLess: othLessParam,
              freight: freightParam,
              iGst: iGstParam,
              sGst: sGstParam,
              cGst: cGstParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          obx_int.InternalToManyAccess.setRelInfo<Invoice>(
              object.items,
              store,
              obx_int.RelInfo<InvoiceItem>.toOneBacklink(
                  7, object.id, (InvoiceItem srcObject) => srcObject.invoice));
          return object;
        }),
    InvoiceItem: obx_int.EntityDefinition<InvoiceItem>(
        model: _entities[1],
        toOneRelations: (InvoiceItem object) => [object.invoice],
        toManyRelations: (InvoiceItem object) => {},
        getId: (InvoiceItem object) => object.id,
        setId: (InvoiceItem object, int id) {
          object.id = id;
        },
        objectToFB: (InvoiceItem object, fb.Builder fbb) {
          final chalanOffset = fbb.writeString(object.chalan);
          final itemNameOffset = fbb.writeString(object.itemName);
          final takaOffset = fbb.writeString(object.taka);
          final qtyOffset = fbb.writeString(object.qty);
          final rateOffset = fbb.writeString(object.rate);
          final hsnCodeOffset = fbb.writeString(object.hsnCode);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, chalanOffset);
          fbb.addOffset(2, itemNameOffset);
          fbb.addOffset(3, takaOffset);
          fbb.addOffset(4, qtyOffset);
          fbb.addOffset(5, rateOffset);
          fbb.addInt64(6, object.invoice.targetId);
          fbb.addOffset(7, hsnCodeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final chalanParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final itemNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final takaParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final hsnCodeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 18, '');
          final qtyParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final rateParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final object = InvoiceItem(
              chalan: chalanParam,
              itemName: itemNameParam,
              taka: takaParam,
              hsnCode: hsnCodeParam,
              qty: qtyParam,
              rate: rateParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.invoice.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.invoice.attach(store);
          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Invoice] entity fields to define ObjectBox queries.
class Invoice_ {
  /// See [Invoice.id].
  static final id =
      obx.QueryIntegerProperty<Invoice>(_entities[0].properties[0]);

  /// See [Invoice.invoiceNo].
  static final invoiceNo =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[1]);

  /// See [Invoice.date].
  static final date =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[2]);

  /// See [Invoice.companyName].
  static final companyName =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[3]);

  /// See [Invoice.address].
  static final address =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[4]);

  /// See [Invoice.gstNumber].
  static final gstNumber =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[5]);

  /// See [Invoice.panNumber].
  static final panNumber =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[6]);

  /// See [Invoice.stateCode].
  static final stateCode =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[7]);

  /// See [Invoice.billTaker].
  static final billTaker =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[8]);

  /// See [Invoice.billTakerAddress].
  static final billTakerAddress =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[9]);

  /// See [Invoice.billTakerGSTPin].
  static final billTakerGSTPin =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[10]);

  /// See [Invoice.deliveryFirm].
  static final deliveryFirm =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[11]);

  /// See [Invoice.deliveryFirmAddress].
  static final deliveryFirmAddress =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[12]);

  /// See [Invoice.deliveryFirmGSTPin].
  static final deliveryFirmGSTPin =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[13]);

  /// See [Invoice.broker].
  static final broker =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[14]);

  /// See [Invoice.discount].
  static final discount =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[15]);

  /// See [Invoice.othLess].
  static final othLess =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[16]);

  /// See [Invoice.freight].
  static final freight =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[17]);

  /// See [Invoice.iGst].
  static final iGst =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[18]);

  /// See [Invoice.sGst].
  static final sGst =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[19]);

  /// See [Invoice.cGst].
  static final cGst =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[20]);

  /// See [Invoice.bankName].
  static final bankName =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[21]);

  /// See [Invoice.bankBranch].
  static final bankBranch =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[22]);

  /// See [Invoice.bankAccountNo].
  static final bankAccountNo =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[23]);

  /// See [Invoice.bankIFSCCode].
  static final bankIFSCCode =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[24]);

  /// See [Invoice.remark].
  static final remark =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[25]);

  /// See [Invoice.mobileNo].
  static final mobileNo =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[26]);

  /// See [Invoice.billTakerMobileNo].
  static final billTakerMobileNo =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[27]);

  /// See [Invoice.deliveryFirmMobileNo].
  static final deliveryFirmMobileNo =
      obx.QueryStringProperty<Invoice>(_entities[0].properties[28]);

  /// see [Invoice.items]
  static final items =
      obx.QueryBacklinkToMany<InvoiceItem, Invoice>(InvoiceItem_.invoice);
}

/// [InvoiceItem] entity fields to define ObjectBox queries.
class InvoiceItem_ {
  /// See [InvoiceItem.id].
  static final id =
      obx.QueryIntegerProperty<InvoiceItem>(_entities[1].properties[0]);

  /// See [InvoiceItem.chalan].
  static final chalan =
      obx.QueryStringProperty<InvoiceItem>(_entities[1].properties[1]);

  /// See [InvoiceItem.itemName].
  static final itemName =
      obx.QueryStringProperty<InvoiceItem>(_entities[1].properties[2]);

  /// See [InvoiceItem.taka].
  static final taka =
      obx.QueryStringProperty<InvoiceItem>(_entities[1].properties[3]);

  /// See [InvoiceItem.qty].
  static final qty =
      obx.QueryStringProperty<InvoiceItem>(_entities[1].properties[4]);

  /// See [InvoiceItem.rate].
  static final rate =
      obx.QueryStringProperty<InvoiceItem>(_entities[1].properties[5]);

  /// See [InvoiceItem.invoice].
  static final invoice =
      obx.QueryRelationToOne<InvoiceItem, Invoice>(_entities[1].properties[6]);

  /// See [InvoiceItem.hsnCode].
  static final hsnCode =
      obx.QueryStringProperty<InvoiceItem>(_entities[1].properties[7]);
}
