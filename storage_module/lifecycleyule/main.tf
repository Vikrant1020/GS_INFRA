resource "azurerm_storage_management_policy" "example" {
  storage_account_id = var.storage_account_id #azurerm_storage_account.storage.id

  rule {
    name    = "dev_tier_rule"
    enabled = var.rule_enable
    filters {
      prefix_match = [var.container_name]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_creation_greater_than  = var.time_to_move_to_cool
        tier_to_archive_after_days_since_creation_greater_than = var.time_to_move_to_archive
      }
    }
  }
}