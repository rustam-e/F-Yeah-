class PostsController < ApplicationController
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id # assign the post to the user who created it.
        @poster = User.find(@post.user_id).username
        respond_to do |f|
            if (@post.save)
                f.html {redirect_to "/user/" + @poster, notice: "Post created!" }
            else
                f.html {redirect_to "", notice: "Error: Post not saved."}
            end
        end
    end
    
    private
    def post_params #allows certain data to be passed via form.
        params.require(:post).permit(:user_id, :content)
    end
end