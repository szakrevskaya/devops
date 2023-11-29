provider "aws" {
    region = "us-east-1"
}

locals {
  parameters = {
    #########
    # String
    #########
    "string_simple" = {
      value = "string_value123"
    }
    "string" = {
      type            = "String"
      value           = "string_value123"
      overwrite       = true
      tier            = "Intelligent-Tiering"
      allowed_pattern = "[a-z0-9_]+"
    }

    ###############
    # SecureString
    ###############
    "secure" = {
      type        = "SecureString"
      value       = "secret123123!!!"
      tier        = "Advanced"
      description = "My awesome password!"
    }

    #############
    # StringList
    #############
    "list_as_autoguess_type" = {
      values = ["item1", "item2"]
    }
    "list_as_jsonencoded_string" = {
      type  = "StringList"
      value = jsonencode(["item1", "item2"])
    }
    "list_as_plain_string" = {
      type  = "StringList"
      value = "item1,item2"
    }
    "list_as_autoconvert_values" = {
      type   = "StringList"
      values = ["item1", "item2"]
    }
    "list_empty_as_jsonencoded_string" = {
      type  = "StringList"
      value = jsonencode([])
    }
  }
}

module "multiple" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  for_each = local.parameters

  name            = try(each.value.name, each.key)
  value           = try(each.value.value, null)
  values          = try(each.value.values, [])
  type            = try(each.value.type, null)
  secure_type     = try(each.value.secure_type, null)
  description     = try(each.value.description, null)
  tier            = try(each.value.tier, null)
  key_id          = try(each.value.key_id, null)
  allowed_pattern = try(each.value.allowed_pattern, null)
  data_type       = try(each.value.data_type, null)
}