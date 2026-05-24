# Tests for OPA Rego policies
package kubernetes.admission

test_approved_image_passes {
    is_signed("myPremiumACR/app:1.0")
    approved_base("gcr.io/distroless/base")
}
