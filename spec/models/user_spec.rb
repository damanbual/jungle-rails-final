RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user_params) do
      { name: 'John Doe', email: 'test@example.com', password: 'password123', password_confirmation: 'password123' }
    end

    context 'when creating a new user' do
      it 'is valid with valid attributes' do
        user = User.new(user_params)
        expect(user).to be_valid
      end

      it 'is invalid without a name' do
        user = User.new(user_params.merge(name: ''))
        expect(user).to_not be_valid
      end

      it 'is invalid without an email' do
        user = User.new(user_params.merge(email: nil))
        expect(user).to_not be_valid

      end

      it 'is invalid without a password' do
        user = User.new(user_params.merge(password: nil, password_confirmation: nil))
        expect(user).to_not be_valid
      end

      it 'is invalid if password and password_confirmation do not match' do
        user = User.new(user_params.merge(password_confirmation: 'something_else'))
        expect(user).to_not be_valid
      end

      it 'is invalid if the email is not unique (case insensitive)' do
        User.create!(user_params)  # Create a user to test against
        user = User.new(user_params.merge(email: 'TEST@example.com'))
        expect(user).to_not be_valid
      end
    end

    context 'when password length is not long enough' do
      it 'is invalid if the password is too short' do
        user = User.new(user_params.merge(password: 'short', password_confirmation: 'short'))
        expect(user).to_not be_valid
      end

      it 'is valid if the password is long enough' do
        User.create!(user_params)
      end
    end
  end

  describe '.authenticate_with_credentials' do
    let!(:user) { User.create!(name: 'John Doe', email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

    context 'when valid email and password are provided' do
      it 'returns the user' do
        authenticated_user = User.authenticate_with_credentials('test@example.com', 'password123')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'when email is entered with different case' do
      it 'returns the user when email case is different' do
        authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.COM', 'password123')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'when email has extra spaces' do
      it 'returns the user when email has leading or trailing spaces' do
        authenticated_user = User.authenticate_with_credentials('   test@example.com   ', 'password123')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'when email does not exist' do
      it 'returns nil if the email does not exist' do
        authenticated_user = User.authenticate_with_credentials('missingEmail@example.com', 'password123')
        expect(authenticated_user).to be_nil
      end
    end

    context 'when password is incorrect' do
      it 'returns nil if the password is incorrect' do
        authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongPassword')
        expect(authenticated_user).to be_nil
      end
    end
  end
end
