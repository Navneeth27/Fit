#!/bin/sh
set -e

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm\""
      xcrun mapc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
          install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140628105322170_drop_and_clean_case_indent_dates_uniques.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140628114921198_remove_creator_id_from_tombstone_wipe_for_ordering.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140701095427050_add_trigger_for_messaging_receipts.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140701114842931_add_timestamps_back_to_messages.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140701144934637_adjust_constraints_of_receipts_table.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140706185141044_add_object_identifiers.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140707082435390_drop_tombstone_trigger.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140707175635814_add_is_draft_to_messages.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140708092626927_adjust_triggers_for_drafting.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140708154438053_change_insert_trigger_on_messages.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140709095453868_drop_track_sending_of_messages.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140715104949748_drop_message_index_table_add_message_index_column.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140717013309255_drop_is_draft_from_messages.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140717021208447_restore-lost-triggers.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140806143305965_add_created_at_to_conversations.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140820112730372_add_unique_constraint_to_message_recipient_status.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20140919115201707_create_synced_changes_table_and_decouple_models.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141002091849299_correct-track_inserts_of_events_delete.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141002175255465_making_version_a_required_field.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141002175510495_track_streams_and_stream_members_with_deleted_at_column.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141006140917614_add-client_id.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141006202908488_add_tombstone_duplicate_events_by_client_id.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141007110138268_client-id-indices.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141009125004707_min-max-synced-seq.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141009125010758_indices.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141027152445461_fix_invalid_identifier_types.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141105082802353_add_unread_fields_to_models.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20141110114425514_remote_keyed_values.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/20150207191203003_create_block_list.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle/layer-client-messaging-schema.sql"
                    install_resource "LayerKit/LayerKit.embeddedframework/LayerKit.framework/Versions/A/Resources/layer-client-messaging-schema.bundle"
          
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
then
  case "${TARGETED_DEVICE_FAMILY}" in
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;
  esac
  find "${PWD}" -name "*.xcassets" -print0 | xargs -0 actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
