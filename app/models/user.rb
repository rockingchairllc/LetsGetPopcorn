class User < ActiveRecord::Base
  
  has_many :authentications
  has_many :albums, :dependent => :destroy
  has_many :favmovies
  has_many :funnyques
  has_many :synopses
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessor :login
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :username, :login, :birthday, :zip, :gender, :orientation, :profile_photo
  
  
  
  #for profile photo
  
  has_attached_file :profile_photo, 
        :styles => { :thumb => "80x75" },
        
        :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
        :path => "user_photo/:id/:style/:basename.:extension",
        :convert_options => {
              :thumb => "-background '#F7F4F4' -compose Copy -gravity center -extent 80x75"
          }
  
  
  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'facebook'
      self.apply_facebook(omniauth)
    end
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end 
  
  
  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end
  
  

  def password_required?
    (authentications.empty? || !password.blank?) && super  
    end                                                
         
      def update_with_password(params={}) 
      if params[:password].blank? 
        params.delete(:password) 
        params.delete(:password_confirmation) if 
    params[:password_confirmation].blank? 
      end 

      update_attributes(params) 
    end
     
         protected

    def apply_facebook(omniauth)
      if (extra = omniauth['extra']['user_hash'] rescue false)
        self.email = (extra['email'] rescue '')
      end
    end
    
    def self.find_for_authentication(warden_conditions)
       conditions = warden_conditions.dup
       login = conditions.delete(:login)
       where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
     end
     
     protected
     
     def self.reset_password_keys
     [:login]
     end

      # Attempt to find a user by it's email. If a record is found, send new
      # password instructions to it. If not user is found, returns a new user
      # with an email not found error.
      def self.send_reset_password_instructions(attributes={})
        recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
        recoverable.send_reset_password_instructions if recoverable.persisted?
        recoverable
      end 

      def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
        (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

        attributes = attributes.slice(*required_attributes)
        attributes.delete_if { |key, value| value.blank? }

        if attributes.size == required_attributes.size
          if attributes.has_key?(:login)
             login = attributes.delete(:login)
             record = find_record(login)
          else  
            record = where(attributes).first
          end  
        end  

        unless record
          record = new

          required_attributes.each do |key|
            value = attributes[key]
            record.send("#{key}=", value)
            record.errors.add(key, value.present? ? error : :blank)
          end  
        end  
        record
      end

      def self.find_record(login)
        where(["username = :value OR email = :value", { :value => login }]).first
      end
      
      
       # After create a new user then send welcome email
       after_create :send_welcome_email 

        private

          def send_welcome_email
            Useremailer.deliver_welcome_email(self)
          end
     
    
end