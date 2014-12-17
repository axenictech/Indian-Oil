// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


function  moveActivity(self){
    $.get($(self).data('href'), function(data){
	$(".activityTabel tbody").html(""+data.html);
    },function(){}, "JSON")
};


function  filterActivity(self){
	$.post($(self).attr("filter_path"),{job_id: $(self).attr("job_id"),status: $(self).val()}, function(data){
	$(".activityTabel tbody").html(""+data.html);
	});
   };
function  filterUserActivity(self){
	$.post($(self).attr("filter_path"),{status: $(self).val()}, function(data){
	$("#user_activities").html(""+data.html);
	});
   };

// Open a popup for rejection of activity
function rejectActivity(self){
	id = $(self).data('actid');
	rej_id = $('#reject_' + id).val();
	if (id && rej_id){
		$("#dialog-act").modal({ keyboard: false });
		$("#rej_id").val(rej_id);
		$("#current_act_id").val(id);
	} else {
		alert('Please select an Activity to be rejected');
	}
};

// Open a popup to show remarks for rejected activity
function showRemarksActivity(self){
	remarks = $(self).data('actremarks');
	$("#dialog-remarks").modal({ keyboard: false });
	if (remarks){
		$("#remarks-given").html(remarks);
	} else {
		$("#remarks-given").html('No remarks specified while rejection of activity');
	}
};



// Open a popup to show remarks for rejected activity (ADMIN SIDE)
function showRemarksActivityAdmin(self){
	remarks = $(self).data('actremarks');
	$("#dialog-remarks-admin").modal({ keyboard: false });
	if (remarks){
		$("#remarks-given-admin").html(remarks);
	} else {
		$("#remarks-given-admin").html('No remarks specified while rejection of activity');
	}
};