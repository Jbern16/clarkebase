require 'rails_helper'

RSpec.describe KeyCleanerService do
  xit "can  " do
    private_key = OpenSSL::PKey::RSA.generate(2048).to_pem
    wallet      = create(:wallet, private_key: private_key)

    expect(wallet.private_key).to eq(private_key)
  end

  xit "can decrypt with the private key after storing it" do
    original_keypair = OpenSSL::PKey::RSA.generate(2048)
    wallet           = create(:wallet, private_key: original_keypair.to_pem)
    test_string      = "this is a test"

    db_keypair = OpenSSL::PKey::RSA.new(wallet.private_key)
    encrypted  = original_keypair.private_encrypt(test_string)
    decrypted  = db_keypair.public_decrypt(encrypted)

    expect(decrypted).to eq(test_string)
  end
end