<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Comment extends Model
{
    use HasFactory;
    protected $fillable = ['body','user_id','post_id'];
    public function post()
    {
        return $this->belongsTo(Post::class);
    }
    public function user(): BelongsToMany
    {
        return $this->belongsToMany(User::class,'user_comment')->orderBy('created_at','desc');
    }
}
