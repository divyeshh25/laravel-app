<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>

{{-- Fixed Navbar = layout-navbar-fixed --}}
{{-- Fixed Sidebar = layout-fixed --}}
{{-- Fixed Footer = layout-footer-fixed --}}
<div class="wrapper">
    <x-navbar.navbar></x-navbar.navbar>
    <x-sidebar.sidebar></x-sidebar.sidebar>
    <x-navbar.footer></x-navbar.footer>
    <section class="content-wrapper">
        <div class="container-fluid">


            {{-- <div class="row">
                <x-cards.sm-card bgcolor='bg-info' icon="fas fa-home" msg1='Home' msg2='10001' />
                <x-cards.sm-card bgcolor='bg-success' icon="fas fa-envelope" msg1='Message' msg2='10001' />
                <x-cards.sm-card/>

            </div> --}}
            <div class="row">
                <x-cards.xl-card icon='fas fa-podcast' bgcolor="bg-warning" total='{{ $posts }}' text1='Posts'/>
                <x-cards.xl-card icon='fas fa-comment' bgcolor="bg-danger" total='{{ $comments }}' text1='Comments'/>
            </div>
        </div>
    </section>
</div>
