require "spec_helper"

RSpec.describe Simple::Redis::Sessions do
  before(:example) do
    SimpleRedisSessions::RedisSessions.reset
    @settings = {
      endpoint: "redis://localhost:6379/test",
      session_life: 60
    }
    @session_id = '123'
    @user_id = '456'
  end

  it "has a version number" do
    expect(Simple::Redis::Sessions::VERSION).not_to be nil
  end

  it "check redis server connection" do
    sessions = SimpleRedisSessions::RedisSessions.connect(@settings)
    sessions.sessions_server_alive?
  end

  it "reset the connection" do
    object1 = SimpleRedisSessions::RedisSessions.connect(@settings)
    SimpleRedisSessions::RedisSessions.reset
    object2 = SimpleRedisSessions::RedisSessions.connect(@settings)

    expect(object1).to_not eq(object2)
  end

  it "check redis sessions is a singleton object" do
    object1 = SimpleRedisSessions::RedisSessions.connect(@settings)
    object2 = SimpleRedisSessions::RedisSessions.connect(@settings)

    expect(object1).to eq(object2)
  end

  it "check a sessions is created successfully" do
    sessions = SimpleRedisSessions::RedisSessions.connect(@settings)
    sessions.create_session(@session_id, @user_id)

    expect(sessions.user_id_from_session_id(@session_id)).to eq(@user_id)
  end

  it "check a session is destroyed" do
    sessions = SimpleRedisSessions::RedisSessions.connect(@settings)
    sessions.create_session(@session_id, @user_id)
    
    sessions.destroy_session(@session_id)
    expect(sessions.user_id_from_session_id(@session_id)).to be nil
  end

  it "check a session expire" do
    @settings[:session_life] = 1
    sessions = SimpleRedisSessions::RedisSessions.connect(@settings)
    sessions.create_session(@session_id, @user_id)

    expect(@user_id).to eq(sessions.user_id_from_session_id(@session_id))
    sleep(3)
    expect(sessions.user_id_from_session_id(@session_id)).to be nil
  end
end
