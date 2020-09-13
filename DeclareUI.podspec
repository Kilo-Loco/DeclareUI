Pod::Spec.new do |spec|

  spec.name         = "DeclareUI"
  spec.version      = "0.3.3"
  spec.summary      = "Declarative framework wrapping UIKit constraints"
  spec.description  = "This framework is meant to make setting up constraints of a UIKit project more declarative and look similar to SwiftUI."
  spec.homepage     = "https://github.com/Kilo-Loco/DeclareUI"
  spec.license      = "MIT"
  spec.author             = { "Kilo Loco" => "kyle@kiloloco.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/Kilo-Loco/DeclareUI.git", :tag => "0.3.3" }
  spec.source_files  = "Source/*.{h,m,swift}"
  spec.swift_versions = "5.1"

end
