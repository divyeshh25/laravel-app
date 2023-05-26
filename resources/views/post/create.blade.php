@can('write post')
<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"/>
<x-sidebar.sidebar />
<x-navbar.navbar />

<section class="content-wrapper">
    <div class="container-fluid">
        {{-- {{ dd($categories) }} --}}
        <div class="card bg-light mt-4 h-auto">
            <h1 class="rounded text-center mb-2 text-bold text-lg-center text-xl">Add Post</h1>
            <div class="card-body m-2 shadow-lg">
                <x-post-form btnType='submit' iDName='add' action="{{ route('posts.store') }}" method="POST" otherMethod='' :data="$categories"/>
            </div>
        </div>
    </div>
</section>

<script>
$(document).ready(function() {
  $('#addBody').summernote({
    height: 150
  });
});
$('#addImg').dropify();

</script>
@else
    <script>window.location = "/error";</script>
@endcan
